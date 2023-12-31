require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'すべてが正しく入力される' do
        expect(@user).to be_valid
      end
      it 'passwordが半角英数字混合で入力される' do
        @user.password = "123ninon"
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合は登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailは@を含まない登録できない" do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = '12345'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが129文字以上では登録できない" do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it '半角英字のみでは登録できない' do
        @user.password = 'aaaaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字混合で入力してください")
      end
      it '半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字混合で入力してください")
      end
      it '全角文字を含むパスワードは登録できない' do
        @user.password = 'あいうえおかき'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角英数字混合で入力してください")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'name_lastが空では登録できない' do
        @user.name_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name last can't be blank")
      end
      it 'name_lastが半角では登録できない' do
        @user.name_last = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name last は全角ひらがな、全角カタカナ、漢字で入力してください")
      end
      it 'name_firstが空では登録できない' do
        @user.name_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name first can't be blank")
      end
      it 'name_firstが半角では登録できない' do
        @user.name_first = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name first は全角ひらがな、全角カタカナ、漢字で入力してください")
      end
      it 'katakana_lastが空では登録できない' do
        @user.katakana_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana last can't be blank")
      end
      it 'katakana_lastが半角では登録できない' do
        @user.katakana_last = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana last は全角カタカナで入力してください")
      end
      it 'katakana_firstが空では登録できない' do
        @user.katakana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana first can't be blank")
      end
      it 'katakana_firstが半角では登録できない' do
        @user.katakana_first = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana first は全角カタカナで入力してください")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
