class UsersController < ApplicationController

  def index
    @se = Digest::MD5.hexdigest("ebskey|<Account number>|1000|<reference no>|http://localhost:3000/users/res?DR={DR}|TEST")
  end

  def show
    require 'rc4'
    require 'base64'
    @key = 'ebskey'
    @DR = params[:DR]
    @DR.gsub!(/ /,'+')
    @encrypted_data = Base64.decode64(@DR)
    @decryptor = RC4.new(@key)
    @plain_text = @decryptor.encrypt(@encrypted_data)
    raise @plain_text.split("&").inspect
  end
end
