#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>


int main(){
    int a,b,c;
    printf("Enter the three sides of the triangle:\n");
    scanf("%d %d %d",&a,&b,&c);
    if((a>10) || (b>10) || (c>10)){
        printf("Out of range");
        exit(0);
    }
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
