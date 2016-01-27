class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      # Lembre-se de alterar a linha a seguir!
      # mude de params[:user] para user_params.
     @user = User.new(user_params)
     if @user.save
       #se salvar o usuário eu desparo o email
       Signup.confirm_email(@user).deliver
       redirect_to @user, notice: 'Cadastro criado com sucesso!'
     else
       render action: :new
     end
   end

   def show
     @user = User.find(params[:id])
   end

   def edit
     @user = User.find(params[:id])
   end

   def update
     @user = User.find(params[:id])
     if @user.update(user_params)
        redirect_to @user, notice: 'Cadastro atualizado com sucesso!'
     else
        render action: :edit
     end
   end
 
   private
 
   def user_params
     params.require(:user).permit(:email, :full_name, :location, :password, :password_confirmation, :bio)
   end
end
