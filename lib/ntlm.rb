require 'net/ntlm'
require 'net/ldap'
require 'Kconv'

class Ntlm
  
  def initialize(app, config = {})
    @app = app
    @config = {
      :uri_pattern => /\//,
      :port => 389,
      :search_filter => "(sAMAccountName=%1)"
    }.merge(config)
  end

  def auth(user)
    ldap = Net::LDAP.new
    ldap.host = @config[:host]
    ldap.port = @config[:port]
    ldap.base = @config[:base]
    ldap.auth @config[:auth][:username], @config[:auth][:password] if @config[:auth]
    !ldap.search(:filter => @config[:search_filter].gsub("%1", user)).empty?
  rescue => e
    false
  end

  def call(env)
    if env['PATH_INFO'] =~ @config[:uri_pattern] && env['HTTP_AUTHORIZATION'].blank?
      return [401, {'WWW-Authenticate' => "NTLM"}, []]
    end

    if /^(NTLM|Negotiate) (.+)/ =~ env["HTTP_AUTHORIZATION"]

      message = Net::NTLM::Message.decode64($2)

      if message.type == 1 
        type2 = Net::NTLM::Message::Type2.new
        return [401, {"WWW-Authenticate" => "NTLM " + type2.encode64}, []]
      end

      if message.type == 3 && env['PATH_INFO'] =~ @config[:uri_pattern]
        domain = Kconv.kconv(Net::NTLM::swap16(message.domain), Kconv::ASCII, Kconv::UTF16)
        user = Kconv.kconv(Net::NTLM::swap16(message.user), Kconv::ASCII, Kconv::UTF16)
        puts "User = #{user}"
        puts "Domain = #{domain}"
        #if auth(user)
          env['REMOTE_USER'] = user 
        #else
        #  return [401, {}, ["You are not authorized to see this page"]]
        #end
      end
    end

    @app.call(env)
  end

end
