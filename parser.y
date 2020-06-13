%{
package main
import "math"
%}

// 用于 lexer 传递内容，会被添加到 yySymType 结构体中
%union {
	number float64
}

// 标记：定义 lexer 分析的出类型
%token <number> number

// 匹配模式
%type <number> expr result

// 定义结合性和优先级
%left '+' '-'
%left '*' '/'
%right '^'

// 优先一元负数
%precedence unary_minus

%%

result
: expr { parser.result = $1 }

expr
: expr '*' expr { $$ = $1 * $3 }
| expr '/' expr { $$ = $1 / $3 }
| expr '+' expr { $$ = $1 + $3 }
| expr '-' expr { $$ = $1 - $3 }
| expr '^' expr { $$ = math.Pow($1, $3) }
| '-' expr %prec unary_minus { $$ = -$2 }
| '(' expr ')' { $$ = $2 }
| number
;

%%