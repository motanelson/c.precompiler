int sum(int a,int b){ 
  int ii=0;
  int l=0;
  char i[]={"hello world...\n"};
  while(i[ii]!=0){
       
       ii++;
  }
  l=ii;
  if(a>0 && a<l+1){
	  ii=(int)i[a-1];
  }else{if(a==0){
			ii=(int)l;
		}else{ii=0;}
		}
	
	
  return ii;
}