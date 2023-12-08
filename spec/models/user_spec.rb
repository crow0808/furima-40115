require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての入力事項が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが英字と数字の両方を含んでいれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it '性が全角かな/カナ、漢字であれば登録できる' do
        @user.last_name = '山田やまだヤマダ'
        expect(@user).to be_valid
      end
      it '名が全角かな/カナ、漢字であれば登録できる' do
        @user.first_name = '陸太郎りくたろうリクタロウ'
        expect(@user).to be_valid
      end
      it '性が全角カナであれば登録できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
      it '名が全角カナであれば登録できる' do
        @user.first_name_kana = 'リクタロウ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
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
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '1234abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150, mix_case: true, special_characters: false)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it '性が全角かな/カナ、漢字以外では登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名が全角かな/カナ、漢字以外では登録できない' do
        @user.first_name = 'rikutaro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '性カナが全角カナ以外では登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名カナが全角カナ以外では登録できない' do
        @user.first_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
