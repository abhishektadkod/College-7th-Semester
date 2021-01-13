#include<stdio.h>
int main()
{
int a[20],n,low,high,mid,key,i,flag=0;
printf("Enter the value of n:\n");
scanf("%d",&n);
if(n>0)
{
printf("Enter %d elements in ASCENDING order\n",n);
for(i=0;i<n;i++)
{
scanf("%d",&a[i]);
}
printf("Enter the key element to be searched\n");
scanf("%d",&key);
low=0; high=n-1;
while(low<=high)
{
mid=(low+high)/2;
if(a[mid]==key)
{
flag=1;
break;
}
else if(a[mid]<key)
{
low=mid+1;
}
else
{high=mid-1;
}
}
if(flag==1)
printf("Successful search\nElement found at Location%d\n",mid+1);
else
printf("Key Element not found\n");
}
else
printf("Wrong input");
return 0;
}
