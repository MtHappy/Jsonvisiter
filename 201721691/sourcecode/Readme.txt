・ディレクトリ"1"
/data - example0.json : レポート用配布資料p2の"exmple0.json"
	 - example1.json : "MemberList"が空の場合の動作確認ファイル
	 - example2.json : "Array"が空の場合の動作確認ファイル
	 - example3.json : 不適当な文法に対するsyntax errorの動作確認ファイル failすればよい
	 - example4.json : Obejectの中身が空における動作確認ファイル
	 - example5.json : 空のファイルに対するsyntax errorの動作確認ファイル failすればよい

lexer.rb : jsonの字句解析器クラス
Perser.rb : jsonの構文解析器クラス
test_1.rb : Perser.rbの動作確認プログラム
test_1.sh : test_1.rbを全ファイルに対して動作確認を行うシェルスクリプト
log.txt : test_1.shの処理結果

*Usage
sh test_1.sh > log.txt

・ディレクトリ"2"
example.json : レポート用配布資料p2の"exmple0.json"
lexer.rb : jsonの字句解析器クラス
Perser.rb : jsonの構文解析器およびdotテキスト生成クラス
test_2.rb : Perser.rbの動作確認プログラム
out.dot : test_2.rbの出力結果
out.jpeg : out.dotのgraphviz出力結果

*Usage
ruby test_2.rb -f example.json > out.dot

・ディレクトリ"3"
example.json : レポート用配布資料p2の"exmple0.json"
lexer.rb : jsonの字句解析器クラス
Perser.rb : jsonの構文解析器クラス
Node.rb : 構文解析木のノードおよびdot出力のアクションが実装されたクラス
test_3.rb : Perser.rbおよびNode.rbの動作確認プログラム
out.dot : test_3.rbの出力結果
out.jpeg : out.dotのgraphviz出力結果

*Usage
ruby test_3.rb -f example.json > out.dot

・ディレクトリ"4"
example.json : レポート用配布資料p2の"exmple0.json"
lexer.rb : jsonの字句解析器クラス
Perser.rb : jsonの構文解析器クラス
Node.rb : 構文解析木のノードクラス
Visitor.rb : Visitorクラス
test_3.rb : Perser.rbおよびNode.rb, Visitor.rbの動作確認プログラム
out.dot : test_3.rbの出力結果
out.jpeg : out.dotのgraphviz出力結果

*Usage
ruby test_4.rb -f example.json > out.dot

dot -Tjpeg out.dot -o out.jpeg
