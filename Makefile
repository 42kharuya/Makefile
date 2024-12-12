#ft_printf課題で使われた実際のMakefileを使った解説

#Makefile内で使われる変数設定
NAME	= libftprintf.a
CC		= cc
FLAGS	= -Wall -Wextra -Werror
LIBFT	= ./libft/libft.a
SRCS	= ft_printf.c ft_printf_c.c ft_printf_s.c ft_printf_i.c ft_printf_p.c ft_printf_u.c ft_printf_x.c
#SRCで指定した.cファイルを.oファイルに置換したもの
OBJS	= $(SRCS:.c=.o)
RM		= rm -f


#ルールまたはコマンドの設定


#ここ！！
%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $@


#$(NAME)コマンド設定
#-Cオプションはmakeコマンドを実行する前に任意ディレクトリに移動する
#cpコマンドはLIBFTをNAME(libftprintf.a)ファイルにコピーする(libftprintf.aがない場合は作成してコピーする)
#ar rcsでOBJSをlibftprintf.aに追加(r=新メンバー追加, c=作成or更新, s=シンボルテーブル作成)
$(NAME): $(OBJS)
	make -C libft
	cp $(LIBFT) $(NAME)
	$(AR) rcs $(NAME) $(OBJS)

#allコマンド設定、$(NAME)コマンドと同じ動作をする
all: $(NAME)

#cleanコマンド設定
#make fclean -C libftをコマンドを実行
#$(RM)で.oファイルのみを削除する
clean:
	make fclean -C libft
	$(RM) $(OBJS)

#fcleanコマンド設定
#cleanコマンドの動作に加えて、$(RM)でアーカイブファイルも削除
fclean:	clean
	$(RM) $(NAME)

#reコマンド設定
#fcleanコマンド+allコマンド
re:	fclean	all

#ディレクトリにコマンドと同じ名前のファイルが存在するとうまく以下兄ので独自コマンドを明示的に指定する。
.PHONY:	all clean fclean re