#include<stdio.h>
void start_game(){
    printf("\033c\033[43;30m\nstart game....\n");


}
void main_game(){
    printf("\033[43;30m\nmain game....\n");


}
void end_game(){
    printf("\033[43;30m\nend game....\n");


}

int main(){
    start_game();
    main_game();
    end_game();
    return 0;
}