Attribute VB_Name = "Module1"

Type RECORD
   
    char As Byte
    
End Type



Function hextodec2(x As String) As Integer
   Dim v As Integer
   Dim y As String
   
   UCase (x)
   v = 0
   y = Left$(x, 1)
   If (x >= "0" And x <= "9") Then
        v = (Val(x)) * 16
    Else
        v = (Asc(x) - 65 + 10) * 16
   End If
   y = Right$(x, 1)
   If (x >= "0" And x <= "9") Then
        v = v + (Val(x))
    Else
        v = v + (Asc(x) - 65 + 10)
   End If
   hextodec2 = v
   
End Function


Public Function hextobyte(x As String) As Byte

Dim b As Byte
Dim v As Integer

  v = hextodec2(x)
  b = CByte(v)
  hextobyte = b

End Function

Function changebytes(nam As String, s As Long, e As Long, g As Long, rp As Byte) As Long
Dim tmp As RECORD
Dim i, j As Long

i = s
j = 1

Open nam For Binary As #1
tmp.char = rp
While (i <= e And j <= g)

   Put #1, i, tmp
   j = j + 1
   i = Loc(1)
   
 Loop
 
End Function

Public Function cloned(ByVal tar As String, ByVal src As String, ByVal bstrt As Long, ByVal bend As Long, ByVal gp As Long, ByVal replace As Byte) As Integer
Dim s, e, g, s1 As Long
Dim rp As Byte
Dim stri As String
Dim sfile As Object

s = bstrt
e = bend
g = gp
rp = replace

  If (g <= 0 Or s > e) Then
     cloned = 0
     Exit Function
  End If
  
  If (e > FileLen(src)) Then
     cloned = 0
     Exit Function
 End If
 
  If (Right$(tar, 1) <> "/") Then
    tar = tar & "/"
  End If
  
  Set sfile = CreateObject("scripting.filesystemobject")
  
  While s1 <= e
    
     stri = tar & "file" & Str(s1)
     sfile.copyfile src, stri, 1
     s1 = changebytes(stri, s1, e, g, rp)
     
  Loop
  
  cloned = 1
  

End Function


  


Type rec
     
    char As Byte

End Type


Function changebytes(nam As String, bs As Long, be As Long, bg As Long, brp As Byte) As Long

Dim tmp As rec
Dim i As Long
Dim j As Long

j = 1
i = bs
tmp.char = brp

Open nam For Binary Access Read Write Shared As #1


While (i <= be And j <= bg)

    Put #1, i, tmp
    j = j + 1
    i = i + 1

Wend
 
Close #1
changebytes = i

End Function

Public Function cloned(tar As String, src As String, st As String, en As String, gr As String, rep As String) As Integer

Dim s As Long
Dim e As Long
Dim g As Long
Dim rp As Byte
Dim sfile As Object
Dim str1 As String
Dim i, totfile As Double

s = Val(st)
e = Val(en)
g = Val(gr)

str1 = "&H"
str1 = str1 & rep
rp = Val(str1)

If (g <= 0 Or s <= 0 Or e <= 0 Or s > e Or e > FileLen(src)) Then
     cloned = 0
     Exit Function
End If
  
  
If (Right$(tar, 1) <> "/") Then
      tar = tar & "/"
End If
  
 totfile = (e - s) / g
 i = 0
 
 Set sfile = CreateObject("scripting.filesystemobject")

 While s <= e
    
     str1 = tar & "file" & Str(s - 1)
     sfile.copyfile src, str1, 1
     s = changebytes(str1, s, e, g, rp)
     Form1.pbar.Value = Form1.pbar.Min + (i / totfile) * (Form1.pbar.Max - Form1.pbar.Min)
     i = i + 1
    
 Wend
     
 Form1.l1.Caption = "TOTAL FILES" & vbCrLf & Str(i)
 Form1.pbar.Value = Form1.pbar.Max
 cloned = 1
  
End Function


Public Function findpathandfile(fullname As String, path As String) As String

Dim y As String
Dim j As Integer

path = fullname
y = Right(path, 1)
j = Len(path)

While j >= 1 And y <> "\"
   
   j = j - 1
   y = Mid(path, j, 1)

Wend
 
y = Right$(path, Len(path) - j)
path = Left$(path, Len(path) - Len(y))
findpathandfile = y

End Function


Public Function exsist(nam As String) As Boolean

On Error GoTo x

  Open nam For Input As #1
  Close #1
  exsist = True
  Exit Function
  
x:
  exsist = False

End Function


