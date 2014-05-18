#encoding: UTF-8

class Task < ActiveRecord::Base

  attr_accessor :registrator, :author, :performer, :controller,
    :co_performers, :informants, :date, :subject, :content, 
    :deadline, :files

  def initialize
    @co_performers = []
    @informants = []
    @date = Time.now 
    @content = ""
    @subject = "Поручение от #{@date.strftime('%d.%m.%Y')}"
    @files = []
  end

  def init(user)
    @registrator = user
    @author = user
    self
  end

end