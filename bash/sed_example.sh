#s for replace, g for glabal
sed "s/<pattern>/<replacement>/g" <src>
#<N> for replacing the <N>st match
sed "s/<pattern>/<replacement>/<N>" <src>
#<N>g for replacing the <N>st and next so on matches
sed "s/<pattern>/<replacement>/<N>g" <src>
#line <a> to <b>
sed "<a>,<b>s/<pattern>/<replacement>/<N>g" <src>
#-i for in-place replacement
sed -i "s/<pattern>/<replacement>/g" <src>
#multiple
sed -i "s/<pattern>/<replacement>/g; s/<pattern>/<replacement>/g" <src>
#ref \1 \0
#N for even line append to odd line
sed "N;s/<pattern>/<replacement>/g" <src>
#i for insert <str> before line <n> 
sed "<n> i <str>" <src>
#a for append <str> after line <n>
sed "<n> a <str>" <src>
#insert/append to every line that matches <patter>
sed "/<patter>/a <str>" <src>
#c for line replacement
sed "<n> c <str>" <src>
sed "/<patter>/c <str>" <src>
#d for delete line
sed "<n> d <str>" <src>
sed "<n>,$ d <str>" <src>
sed "/<patter>/d <str>" <src>
#p for print
sed "/<patter>/p" <src>
#n for not display original lines
sed -n "/<patter>/p" <src>
#line <n> to <pattern>
sed -n "1,/<patter>/p" <src>
#{<actions>}
sed "/<patter>/{<action1>;<action2>;}" <src>
#hold space
#g holdspace > patternspace
#G >$
#h <
#H $<
