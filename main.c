#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int eeppromX(int a,int b){ 
  int ii=0;
  int l=0;
  char i[]={"hello world...\n"};
  
  l=strlen(i);
  if(a>0 && a<l+1){
	  ii=(int)i[a-1];
  }else{if(a==0){
			ii=(int)l;
		}else{ii=0;}
		}
	
	
  return ii;
}