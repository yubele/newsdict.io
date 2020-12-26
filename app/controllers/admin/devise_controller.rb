class Admin::DeviseController < DeviseController
  before_action -> {
    authenticate_user!(force: true)
  }
end