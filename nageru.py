#!/usr/local/bin/python3.4

import io,sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

import os
import cgi
import cgitb
cgitb.enable()


moji={
  "c_t1":"投げる！　(作成中)",
  "c_t2":"投稿",
  "c_t3":"表示",
  "c_submit":"書込",
  "c_return":"戻る",
  "c_item":"title",
  "c_comment":"comment",
  "c_item2":"title:",
  "c_comment2":"comment:"
  }


flg_inp_dsp="inp"
f_tit=""
f_cmt=""
frp=cgi.FieldStorage()
if 'tit' not in frp and 'cmt' not in frp:
  pass
else:
  f_tit=frp['tit'].value if 'tit' in frp else ""
  f_cmt=frp['cmt'].value if 'cmt' in frp else ""
  flg_inp_dsp="dsp"


html='''<!DOCTYPE html>
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
'''

t_css='''
body{
   background-color:aliceblue;
   }
'''

inp_body='''
<div id='d1'>
<form id='fm1' method='post' action=''>
<span id='s1'>%c_item%</span><input id='ip1' type='text' name='tit' size='40'>
<span id='s2'>%c_comment%</span><textarea id='ip2' name='cmt' cols=40 rows=4></textarea>
<input id='ip3' type='submit' value='%c_submit%'>
</form>
</div>
'''

dsp_body='''
<div id='d2'>
<span id='s3'>%c_item2%</span>{f_tit}
</div>
<div id='d3'>
<span id='s4'>%c_comment2%</span>{f_cmt}
</div>
<div id='d4'>
<a href="" id='a1'>%c_return%</a>
</div>
'''

if flg_inp_dsp=="inp":
  t_body=inp_body
else:
  t_body=dsp_body.format(f_tit=f_tit,f_cmt=f_cmt)
  t_title_sub=moji["c_t3"]



t_title="%c_t1%"
t_title_sub="%c_t2%"

for k,v in {"%title%":t_title,"%title_sub%":t_title_sub,"%css%":t_css,"%body%":t_body}.items():
   html=html.replace(k,str(v).strip())

for k,w in moji.items():
   html=html.replace("%"+k+"%",w)


print("Content-Type: text/html; charset=UTF-8\n")
print(html)
   