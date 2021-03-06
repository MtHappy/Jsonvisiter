# 問題記述と形式化課題

## 文法
以下にjsonの文法を示す．  
LBRA = \{  
RBRA = \}  

```
json : object
     | array ;

object : LBRA members RBRA ;

members :
        | memberlist ;

memberlist : pair (COMMA pair)* ;

pair : STRING COLON value ;

array : LBRACKET elements  RBRACKET ;

elements :
         | elementlist ;

elementlist : value (COMMA value)* ;

value : STRING
      | INT
      | FLOAT
      | TRUE
      | FALSE
      | NULL
      | object
      | array
      ;
```

## 下向き構文解析
> 構文解析木を根から葉へと作っていくように行う解析  

例えば，次の文法が存在する．  
```
S : a B c d
  ;

B : b c
  | b
  ;
```

この文法に対する再帰的処理による擬似コードを次に示す．  

```
def mS()
	match('a')
	mB()
	match('c')
	match('d')
end

def mB()
	match('b')
	match('c')
	#if failed, then back-track
	match('d')
end
```

後戻りが大変  
## LL構文解析
> 与えられた文法がLL(1)であるならば，後戻りなしで再帰的下向き構文解析プログラムを機械的に作成する　　
 
後戻りせずに再帰的下向き構文解析を行うためには，以下の条件を満たす必要がある．  
- 左再帰性を文法が持たない
- 生成規則の選択に曖昧性がない

以上の点を調べるために，FIRST集合とFOLLOW集合を利用する．  
なお，jsonはこれを満たしている?

次に生成規則に対する，メソッドの構成を示す．  

### 生成規則の右辺が1つだけの場合
```
if token == a
	token = yylex()#字句解析器
else
	error()
end
```
### 右辺が選択記号(|)で区切られている場合
```
case token
	when FIRST(b1)
		b1process
	when FIRST(b2)
		b2process
	...
end
```

## アクション
> 構文解析時の文法規則に対応した処理のこと

## Parse Tree
抽象構文木 :  
> プログラムの構造の本質だけを表現する

### 実装
ノードの実装 :
```
class Node
	def initialize(label, *children)
		@label = label
		@children = children
	end
end

#usage
n1 = Node.new("1")
n2 = Node.new("2")
np = Node.new("+",n1,n2)
```

オブジェクト指向的な実装 : 
Nodeクラスにevalメソッドを追加する  

#### Visiterパターン
オーバーロードの活用
各ノードがVisitorオブジェクトを受け取れるようにする．  
Visitorオブジェクトを受け取ったノードオブジェクトは，そのVisitorオブジェクトのメソッドに自身を返す．  

```
# Node class
class SampleNode
	attr_reader :val
	def initialize(val)
		@val = val
	end

	def accept(v)
		v.visit(self)
	end
end

# Visitor class
class SampleVisitor
	def initialize
		@nodes = {SampleNode => lambda{|n| n.val}, ...}
	end

	def visit(n)
		@nodes[n.class].call(n)
	end
end

tree = SampleNode.new(Sample_a.new(foo),Sample_b.new(hoge))
puts tree.accept(SampleVisitor.new)
```


