namespace :test do
  desc "Generate factory bot"
  task generate_factory_bot: :environment do |task, args|
    if args.to_a.count == 0
      Rails.application.eager_load!
      models = ApplicationRecord.descendants
    else
      models = Array.new
      args.to_a.each do |name|
        begin
          models << name.constantize
        rescue NameError
          raise "not found model: #{name}"
        end
      end
    end
    models.each do |model|
      name = model.to_s
      filename = Rails.root.join('test', 'fixtures', 'factories', "#{name.underscore}.rb").to_s
      next if File.exists?(filename)
      FileUtils.mkdir_p(File.dirname(filename))
      file = File.open(filename, "w")
      file.puts "FactoryBot.define do\n"
      file.puts "  factory '#{name}' do\n"
      model.attribute_names.each do |attribute_name|
        type = model.fields[attribute_name].options[:type]
        validator = model._validators[:key].find { |v| v.class == Mongoid::Validatable::LengthValidator } || OpenStruct.new({:options => {}})
        is_present = model._validators[:key].find { |v| v.class == Mongoid::Validatable::PresenceValidator }
        is_uniqueness = model._validators[:key].find { |v| v.class == Mongoid::Validatable::UniquenessValidator }
        case type.to_s
        when "BSON::ObjectId", "Object"
          value = "BSON::ObjectId.new"
        when "String"
          case attribute_name
          when "_type"
            value = "\"#{name}\""
          else
            if validator.options[:minimum]
              minimum = validator.options[:minimum]
            elsif is_present && validator.options[:minimum].nil?
              minimum = 1
            else
              minimum = 0
            end
            maximum = validator.options[:maximum] ? validator.options[:maximum] : 255
            if is_uniqueness
              # Not support length
              value = "Faker::Name.unique.name"
            else
              value = "Faker::String.random(length: [#{minimum}, #{maximum}])"
            end
          end
        when "Time", "DateTime"
          value = "Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all)"
        when "Mongoid::Boolean"
          value = "[true, false].sample"
        when "Integer"
          if validator.options[:minimum]
            minimum = validator.options[:minimum]
          elsif is_present && validator.options[:minimum].nil?
            minimum = 1
          else
            minimum = 0
          end
          maximum = validator.options[:maximum] ? validator.options[:maximum] : 255
          value = "Faker::Number.between(from: #{minimum}, to: #{maximum})"
        when "BSON::Binary"
          value = "Faker::String.random"
        when "Array"
          value = "Faker::Types.rb_array"
        else
          binding.pry
          raise "Not support #{type}. please edit lib/tasks/test.rake:generate_factory_bot"
        end
        file.puts "    #{attribute_name} { #{value} }\n" unless attribute_name == "alias"
      end
      file.puts "  end\n"
      file.puts "end\n"
    end
  #rescue => e
  #  p e.message
  end
end