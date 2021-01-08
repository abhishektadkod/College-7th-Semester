#include<stdio.h>
#include<ctype.h>

int main(){
    int a,b,c;
    printf("Enter the three sides of the triangle:\n");
    scanf("%d %d %d",&a,&b,&c);
    if((a<b+c) && (b<a+c) && (c<a+b)){
        if((a==b) && (b==c)){
            printf("Equilateral Triangle\n");
        }
        else if(a!=b && b!=c && c!=a){
            printf("Scalene Triangle\n");
        }
        else{
            printf("Isosceles Triangle\n");
        }
    }
    else{
        printf("Not a triangle\n");
    }
}
