require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:premier)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { first_name:  "Zalupka",
                                    last_name: "Hueva",
                                    email: "foo@invalid",
                                    password_digest: "12345678"}
    assert_template 'users/edit'
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    firstname  = "Foo Bar"
    lastname = 'Zazaz'
    email = "foo@bar.com"
    patch user_path(@user), user: { first_name: firstname, last_name: lastname, email: email }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstname, @user.firstname
    assert_equal lastname,@user.lastname
    assert_equal email, @user.email
  end
end
