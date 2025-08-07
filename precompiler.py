codex ="""void main()
{
    print("\\;\\{\\}\\(\\)\\\"");
}
"""
def encoderx(codex):
    code=codex.replace("\\;",chr(255))
    code=code.replace("\\{",chr(254))
    code=code.replace("\\}",chr(253))
    code=code.replace("\\(",chr(252))
    code=code.replace("\\)",chr(251))
    code=code.replace("\\\"",chr(250))
    return code
    
def dencoderx(codex):
    code=codex.replace(chr(255),";")
    code=code.replace(chr(254),"{")
    code=code.replace(chr(253),"}")
    code=code.replace(chr(252),"(")
    code=code.replace(chr(251),")")
    code=code.replace(chr(250),"\\\"")

    
    return code
code=encoderx(codex)



print("\033c\033[43;30m\n\n")
lines =0
code2=code.split(";")
for n in code2:
    code3=n.split("{")
    code33=0
    for nn in code3:
        code33=code33+1
        if(len(code3)-1==code33):
            print(str(lines)+"___________________"+"{")
        code4=nn.split("}")
        code44=0 
        for nn in code4:
            lines=lines+1
            
            code44=code44+1
            if(len(code4)-1==code44):
                print(str(lines)+"___________________"+"}")
            code5=nn.split(")")
            for nnn in code5:
                
                  code6=nnn.split("(")
                  for nnnn in code6:
                     print(str(lines)+"___________________"+dencoderx(nnnn.strip()))


