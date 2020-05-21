#!/usr/local/bin/ruby2.0
print "Content-type:text/html\n\n"


# nageru.rb ###

moji={
c_t1:"書き込み表示のテスト　(修正削除,表示順は未だ)",
c_t2:"投稿",
c_t3:"表示",
c_submit:"書込",
c_return:"戻る",
c_item:"title",
c_comment:"comment",
c_item2:"title:",
c_comment2:"comment:"
}
t_css=<<EOT
body{
   background-color:chocolate;
   }
.d_cm{
   display:inline-block;
   margin:20px;
   }
.cm_t{
   background-color:yellow;
   }
EOT

#=begin
### 外部化
#require_relative "nageru_css_00.rb"      ### 初期
#require_relative "nageru_css_01.rb"     ### @Reina_birds
require_relative "nageru_css_02.rb"     ### @Reina_birds
css
moji=$moji
t_css=$t_css
#=end


$data_dir="data01"         #投稿データフォルダ

t_title="%c_t1%"
t_title_sub="%c_t2%"


###      書込
def d_write(fmei,fdata)
   if fmei==""
      fmei="put_space"
      fdata=Time.now.to_s
   end
   begin
      File.open($data_dir+"/"+fmei,"a") do |f|
         f.write(fdata+"\n")
      end
   rescue => error
      fdata=fmei
      File.open($data_dir+"/put_error","a") do |f|
         f.write(fdata+"\n")
      end
      return "error"
   end
end

###      読込
def d_list()
   tit_list=Dir.glob("#{$data_dir}/*")
   ret="<h2>bord</h2><div class='d_box'>\n"
   tit_list.each do |w|
      fmei=w[$data_dir.length+1..-1]
      next if fmei=="put_space"
      t=""
      begin
         File.open($data_dir+"/"+fmei,"r:utf-8") do |f|
            f.each_line do |line|
               line.chomp!
               t+=line.encode(Encoding::UTF_8)+"<br>"
              # t+=line+"<br>"
            end
         end
      rescue => error
         t="- read error -"+error.to_s
      end
      t.gsub!(/[\r\n]/,"<br>")
      tit="<div class='cm_t'>#{fmei}</div>\n"
      cmt="<div class='cm_c'>#{t}</div>\n"
      ret+="<div class='d_cm'>\n#{tit}#{cmt}</div>\n"      
   end
   ret+="</div>\n"
   return ret
end



###      切り分け
require'cgi'
cgi=CGI.new

flg_inp_dsp="inp"
f_tit=""
f_cmt=""
check=""
if cgi.has_key?('tit')
  ### postチェック
  ref=ENV['HTTP_REFERER']
  chk=ENV['SERVER_NAME']+ENV['SCRIPT_NAME']
  r=/\/\/(.*)/.match(ref)
  if chk!=r[1] 
     check="post error"
  else
     f_tit=cgi['tit']
     f_tit=CGI.escapeHTML(f_tit)
     f_cmt=cgi['cmt']
     f_cmt=CGI.escapeHTML(f_cmt)
     e=d_write(f_tit,f_cmt)
     if e=="error" then check="write error" end
  end
  flg_inp_dsp="dsp"
end


###                投稿時の画面
inp_body=<<EOT
<div id='d1'>
<form id='fm1' method='post' action=''>
<span id='s1'>%c_item%</span><input id='ip1' type='text' name='tit' size='40'>
<span id='s2'>%c_comment%</span><textarea id='ip2' name='cmt' cols=40 rows=4></textarea>
<input id='ip3' type='submit' value='%c_submit%'>
</form>
</div>
EOT

###                投稿後の画面
dsp_body=<<EOT
<div id='d2'>
<span id='s3'>%c_item2%</span>#{f_tit}
</div>
<div id='d3'>
<span id='s4'>%c_comment2%</span>#{f_cmt}
</div>
<div id='d4'>
<a href="" id='a1'>%c_return%</a>
</div>
EOT


###      表示
if flg_inp_dsp=="inp" then 
  t_body=inp_body+d_list
else
  if check!=""
     t_body=check+"<br><a href=''>return</a>"
  else
     t_body=dsp_body+"<br>"
  end
  t_title_sub="%c_t2%"
end


whtml=DATA.read

whtml.gsub!("%title%",t_title)
whtml.gsub!("%title_sub%",t_title_sub)
whtml.gsub!("%css%",t_css.chomp)
whtml.gsub!("%body%",t_body.chomp)

moji.each do |k,v|
   whtml.gsub!("%"+k.to_s+"%",v)
end

print whtml

### 確認用html出力
#File.open("w.html","w") do |f|
#   f.puts(whtml)
#end

__END__
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
<title>%title%</title>
<style>
%css%
</style>
</head>
<body>
<h1>%title%</h1>
<hr>
<h2>%title_sub%</h2>
<div id='d0'>
%body%
</div>
<script>
</script>
</body>
</html>
