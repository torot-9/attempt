check=""
if cgi.has_key?('tit')
  ### postチェック
  ref=ENV['HTTP_REFERER']
  chk=ENV['SERVER_NAME']+ENV['SCRIPT_NAME']
  r=/\/\/(.*)/.match(ref)
  if chk!=r[1] 
     check="post error"
  else
  end
end
