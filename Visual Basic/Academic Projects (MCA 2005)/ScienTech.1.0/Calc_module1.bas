Attribute VB_Name = "CalcFuns"

'---Only use Uppercase letters for Memory
'---Only use Lowercase letters for Operators
'---Only use Lowercase letters for function
'---Never use mixture of lower & upper case letters

               '-----------Upgradable Scientific Calculator-------------'
                
'--Add more functions & operators in Set_Functions() and Set_Operators() if needed--'
'--Define them in Evaluate_Function() and Evaluate_Operators() respectively--'
'--No two operator must have the same syntax--'
'--No Operator must be equal to any Function in syntax--'
'--No two functions must have the same syntax--'
'--No Function must be equal to any Operator in syntax--'
'--ie each function name and each operator must be unique in syntax, They are all need to be distinct--'
'--Similar restrictions to PreFix & PostFix operators--'

'---Always add Operators or Functions to the end of Operator_List or Fuction_List respectively--'
'---Define functions and operators in Evaluate_Function() & Evaluate_Operators() respectively, with thier index--'
'---Always assign priority to new operators, and must be > 0. --'
'---Never try to change the order of function & operators in their respective array--'
'---It is recommended to not to change Function-Names and Operator-Symbols--;
'---Always use lower case letters to add functions & Operators--'


'--ex:You cannot add a new Operator named "log", since there is a function named "log"--'
'--ex:You cannot add a new Function named "mod", since there is an operator named "mod"--'
'--ex:You cannot add a new function named "exp", since there is a function with the same name--'
'--ex:You cannot add a new operator named "+", since there is an operator with the same syntax--'

'--ex:To add a new Operator say "new+", increment "o.cnt" by 1 in Set_Operators() first--'
'--Then add codes such as o.optr([o.cnt-1])="new+" and o.prior([o.cnt-1])=some +value--'
'--Note that [o.cnt-1] represent it's absolute value such as 8 or 9.., not enter this expression as such--'
'--Now goto function Evaluate_Operators() and define the added function, such as --'
'--Case .optr([o.cnt-1]): res = sin(CDbl(op1))+cos(CDbl(op2)), note again [o.cnt-1]--'

'--Adding function[Set_Functions()] is more simple, but note the following--'
'--If your function depends on Radian,Degree,Gradient consider the 2-For loops in the function[Evaluate_Function()]--'
'--change them accordingly or add new code or loop where ever necessory--'


Option Explicit

Type memory
    nam() As String
    value() As String
    cnt As Long
End Type
    
Type functions
    funs() As String
    cnt As Long
End Type

Type operators
    optr() As String
    prior() As Long
    cnt As Long
End Type

Type stack
    item() As String
    top As Long
End Type

Type MQueue
    Size As Long
    Aray() As String
    Xist() As Boolean
    Front As Long
    Current As Long
End Type
    
    
Public fun As functions
Public opr As operators
Public preoptr As functions
Public postoptr As functions

Public Sub InitiateMQ(mq As MQueue, Size As Long)
Dim i As Long
    
    mq.Size = Size
    ReDim mq.Aray(mq.Size - 1) As String
    ReDim mq.Xist(mq.Size - 1) As Boolean
    mq.Front = -1
    mq.Current = -1
    For i = 0 To mq.Size - 1 Step 1
        mq.Xist(i) = False
    Next i
End Sub

Public Function MQinsert(mq As MQueue, value As String) As String
    mq.Front = (mq.Front + 1) Mod mq.Size
    mq.Xist(mq.Front) = True
    mq.Aray(mq.Front) = value
    mq.Current = mq.Front
    MQinsert = mq.Aray(mq.Front)
End Function

Public Function MQgetPrev(mq As MQueue) As String
Dim tmp As Long

    With mq
        If .Current = -1 Then
            MQgetPrev = "NULL"
            Exit Function
        End If
        tmp = IIf(.Current = 0, .Size - 1, .Current - 1)
        If tmp = .Front Or .Xist(tmp) = False Then
            MQgetPrev = "NULL"
            Exit Function
        End If
        .Current = tmp
        MQgetPrev = .Aray(.Current)
    End With
End Function

Public Function MQgetNext(mq As MQueue) As String
Dim tmp As Long
    With mq
        If .Current = -1 Then
            MQgetNext = "NULL"
            Exit Function
        End If
        tmp = (.Current + 1) Mod .Size
        If tmp = ((.Front + 1) Mod .Size) Or .Xist(tmp) = False Then
            MQgetNext = "NULL"
            Exit Function
        End If
        .Current = tmp
        MQgetNext = .Aray(.Current)
    End With
End Function


Public Sub InitiateStack(s As stack)
    s.top = -1
End Sub

Public Function StackTopItem(s As stack) As String
    If s.top <> -1 Then
        StackTopItem = s.item(s.top)
    Else
        StackTopItem = "NULL"
    End If
End Function

Public Function push(s As stack, item As String) As String
    If s.top = -1 Then
        s.top = 0
        ReDim s.item(s.top) As String
    Else
        s.top = s.top + 1
        ReDim Preserve s.item(s.top) As String
    End If
    s.item(s.top) = item
    push = item
End Function

Public Function StackEmpty(s As stack) As Boolean
    If s.top = -1 Then
        StackEmpty = True
    Else
        StackEmpty = False
    End If
End Function

Public Function pop(s As stack) As String
    If StackEmpty(s) Then
        pop = "NULL"
    Else
        pop = s.item(s.top)
        s.top = s.top - 1
        If s.top <> -1 Then
            ReDim Preserve s.item(s.top) As String
        End If
    End If
End Function


'--------Call always initially--------------'
Public Sub Set_Operators(o As operators)
    
    '----------Add number of operators supported-----------'
    o.cnt = 10
    ReDim o.optr(o.cnt) As String
    ReDim o.prior(o.cnt) As Long
    '----------Add more operators here---------------------'
    With o
        .optr(0) = "mod"
        .prior(0) = 2
        
        .optr(1) = "div"
        .prior(1) = 2
        
        .optr(2) = "-"
        .prior(2) = 1
        
        .optr(3) = "+"
        .prior(3) = 1
        
        .optr(4) = "*"
        .prior(4) = 3
        
        .optr(5) = "%"
        .prior(5) = 3
        
        .optr(6) = "^"
        .prior(6) = 4
        
        .optr(7) = "e"
        .prior(7) = 4
        
        .optr(8) = "c"
        .prior(8) = 4
        
        .optr(9) = "p"
        .prior(9) = 4
        
     End With

End Sub

Public Function Evaluate_Operators(op1 As Variant, opr As String, op2 As Variant, optrs As operators) As Variant
Dim res As Variant
    '----------Add more operator definitions here if needed---------------'
    opr = LCase(opr)
    With optrs
    Select Case opr
        Case .optr(0): res = IntPart(CDbl(op1)) Mod IntPart(CDbl(op2))
        Case .optr(1): res = IntPart(IntPart(CDbl(op1)) / IntPart(CDbl(op2)))
        Case .optr(2): res = CDbl(op1) - CDbl(op2)
        Case .optr(3): res = CDbl(op1) + CDbl(op2)
        Case .optr(4): res = CDbl(op1) * CDbl(op2)
        Case .optr(5): res = CDbl(op1) / CDbl(op2)
        Case .optr(6): res = CDbl(op1) ^ CDbl(op2)
        Case .optr(7): res = CDbl(op1) * CDbl(Evaluate_Operators(CVar(10#), .optr(6), op2, optrs))
        Case .optr(8): res = CVar(nCr(IntPart(CDbl(op1)), IntPart(CDbl(op2))))
        Case .optr(9): res = CVar(nPr(IntPart(CDbl(op1)), IntPart(CDbl(op2))))
        Case Else: GoTo xit
    End Select
    End With
  Evaluate_Operators = Round(res, 14)
  Exit Function
xit:
    MsgBox "An error occured, Returning 0." + vbCrLf + Err.Description, vbOKOnly, "Mathematical Error"
    Evaluate_Operators = 0#
End Function

'--------Call always initially--------------'
Public Sub Set_PrefixOperators(f As functions)
    With f
        .cnt = 2
        ReDim .funs(.cnt) As String
        .funs(0) = "+"
        .funs(1) = "-"
    End With
End Sub

Public Function Evaluate_PreFix(prefix As String, op As Double, preoptrs As functions) As Double
Dim res As Double
    
    With preoptrs
    Select Case prefix
        Case .funs(0): res = op
        Case .funs(1): res = -op
        Case Else: GoTo xit
    End Select
    Evaluate_PreFix = res
    Exit Function
    End With
xit:
    MsgBox "An error occured, Returning 0." + vbCrLf + Err.Description, vbOKOnly, "Mathematical Error"
    Evaluate_PreFix = 0#
End Function

Public Sub Set_PostfixOperators(f As functions)
    With f
        .cnt = 1
        ReDim .funs(.cnt) As String
        .funs(0) = "!"
    End With
End Sub

Public Function Evaluate_PostFix(op As Double, postfix As String, postoptrs As functions) As Double
Dim res As Double
    
    With postoptrs
    Select Case postfix
        Case .funs(0): res = Factorial(IntPart(op))
        Case Else: GoTo xit
    End Select
    Evaluate_PostFix = res
    Exit Function
    End With
xit:
    MsgBox "An error occured, Returning 0." + vbCrLf + Err.Description, vbOKOnly, "Mathematical Error"
    Evaluate_PostFix = 0#
End Function

Public Sub Set_Functions(f As functions)
    
    '----------Add number of functions supported-----------'
    f.cnt = 32
    ReDim f.funs(f.cnt) As String
       
    '----------Add function Names here----------------------'
    With f
        .funs(0) = "log"
        .funs(1) = "ln"
        .funs(2) = "exp"
        
        .funs(3) = "sin"
        .funs(4) = "cos"
        .funs(5) = "tan"
        .funs(6) = "cosec"
        .funs(7) = "sec"
        .funs(8) = "cot"
        
        .funs(9) = "asin"
        .funs(10) = "acos"
        .funs(11) = "atan"
        .funs(12) = "acosec"
        .funs(13) = "asec"
        .funs(14) = "acot"
        
        .funs(15) = "sinh"
        .funs(16) = "cosh"
        .funs(17) = "tanh"
        .funs(18) = "cosech"
        .funs(19) = "sech"
        .funs(20) = "coth"
        
        .funs(21) = "asinh"
        .funs(22) = "acosh"
        .funs(23) = "atanh"
        .funs(24) = "acosech"
        .funs(25) = "asech"
        .funs(26) = "acoth"
        
        .funs(27) = "sqrt"
        .funs(28) = "sqr"
        .funs(29) = "inv"
        .funs(30) = "int"
        .funs(31) = "fact"
    End With
End Sub

Public Function Evaluate_Function(fun As String, f As functions, op As Double, RadDegGrad As String) As Double
Dim i As Long
Dim res As Double

fun = LCase(fun)
RadDegGrad = Mid(LCase(RadDegGrad), 1, 3)
    '----------Add more function definitions here if needed---------------'
    
    With f
    For i = 3 To 8 Step 1
        If fun = .funs(i) Then
            op = IIf(RadDegGrad = "rad", op, IIf(RadDegGrad = "deg", DegToRad(op), GradToRad(op)))
            Exit For
        End If
    Next i
    
    Select Case fun
        Case .funs(0): res = Log(op) / Log(10#)
        Case .funs(1): res = Log(op)
        Case .funs(2): res = exp(op)
        
        Case .funs(3): res = Sin(op)
        Case .funs(4): res = Cos(op)
        Case .funs(5): res = Tan(op)
        Case .funs(6): res = 1# / Sin(op)
        Case .funs(7): res = 1# / Cos(op)
        Case .funs(8): res = 1# / Tan(op)
        
        Case .funs(9): res = Atn(op / Sqr(-op * op + 1))
        Case .funs(10): res = Atn(-op / Sqr(-op * op + 1)) + 2 * Atn(1#)
        Case .funs(11): res = Atn(op)
        Case .funs(12): res = Atn(op / Sqr(op * op - 1)) + (Sgn(op) - 1) * (2 * Atn(1#))
        Case .funs(13): res = Atn(op / Sqr(op * op - 1)) + Sgn((op) - 1) * (2 * Atn(1#))
        Case .funs(14): res = Atn(op) + 2 * Atn(1#)
        
        Case .funs(15): res = (exp(op) - exp(-op)) / 2#
        Case .funs(16): res = (exp(op) + exp(-op)) / 2#
        Case .funs(17): res = (exp(op) - exp(-op)) / (exp(op) + exp(-op))
        Case .funs(18): res = 2# / (exp(op) - exp(-op))
        Case .funs(19): res = 2# / (exp(op) + exp(-op))
        Case .funs(20): res = (exp(op) + exp(-op)) / (exp(op) - exp(-op))
        
        Case .funs(21): res = Log(op + Sqr(op * op + 1#))
        Case .funs(22): res = Log(op + Sqr(op * op - 1))
        Case .funs(23): res = Log((1# + op) / (1# - op)) / 2#
        Case .funs(24): res = Log((Sgn(op) * Sqr(op * op + 1#) + 1#) / op)
        Case .funs(25): res = Log((Sqr(-op * op + 1#) + 1#) / op)
        Case .funs(26): res = Log((op + 1#) / (op - 1#)) / 2#
        
        Case .funs(27): res = Sqr(op)
        Case .funs(28): res = (op * op)
        Case .funs(29): res = 1# / op
        Case .funs(30): res = IntPart(CDbl(op))
        Case .funs(31): res = Factorial(IntPart(CDbl(op)))
        
        Case Else: GoTo xit
    End Select
    
    For i = 9 To 14 Step 1
        If fun = .funs(i) Then
            res = IIf(RadDegGrad = "rad", res, IIf(RadDegGrad = "deg", RadToDeg(res), RadToGrad(res)))
            Exit For
        End If
    Next i
    
    End With
    Evaluate_Function = Round(res, 14)
    Exit Function
    
xit:
    MsgBox "An error occured, Returning 0." + vbCrLf + Err.Description, vbOKOnly, "Mathematical Error"
    Evaluate_Function = 0#
End Function

Public Function OperatorPriority(ByVal s As String, optrs As operators) As Long
Dim i As Long
    s = LTrim(LCase(s))
    For i = 0 To optrs.cnt - 1 Step 1
        If Mid(s, 1, Len(optrs.optr(i))) = optrs.optr(i) Then
            OperatorPriority = optrs.prior(i)
            Exit Function
        End If
    Next i
    OperatorPriority = -1
End Function

Public Function IntPart(num As Double) As Long
Dim i As Long
Dim s As String

    s = Trim(LCase(Str(num)))
    i = 1
    While i <= Len(s) And Mid(s, i, 1) <> "."
        i = i + 1
    Wend
    i = i - 1
    If i < 1 Then
        IntPart = CLng(0)
    Else
        IntPart = CLng(Trim(Val(Mid(s, 1, i))))
    End If
End Function


Public Function ParseFunction(ByVal s As String, fun As String, length As Long, fs As functions) As Boolean
Dim i As Long
Dim tmp As String
Dim s1() As String
Dim l As Long
Dim max As Long
    
    s = LCase(s)
    tmp = s
    s = LTrim(s)
    
    If s = "" Then
        fun = ""
        length = 0
        ParseFunction = False
        Exit Function
    End If
    
    ReDim s1(0) As String
    l = -1
    
    For i = 0 To fs.cnt - 1 Step 1
        If Mid(s, 1, Len(fs.funs(i))) = fs.funs(i) Then
            l = l + 1
            ReDim Preserve s1(l) As String
            s1(l) = fs.funs(i)
        End If
    Next i
    
    If l = -1 Then
        fun = ""
        length = 0
        ParseFunction = False
    Else
        max = 0
        For i = 1 To l Step 1
            If Len(s1(i)) > Len(s1(max)) Then
                max = i
            End If
        Next i
        fun = s1(max)
        length = Len(s1(max)) + (Len(tmp) - Len(s))
        ParseFunction = True
    End If
    
End Function

Public Function ParseOperator(ByVal s As String, optr As String, length As Long, optrs As operators) As Boolean
Dim i As Long
Dim tmp As String
Dim s1() As String
Dim l As Long
Dim max As Long
    
    s = LCase(s)
    tmp = s
    s = LTrim(s)
    
    If s = "" Then
        optr = ""
        length = 0
        ParseOperator = False
        Exit Function
    End If
    
    ReDim s1(0) As String
    l = -1
    
    For i = 0 To optrs.cnt - 1 Step 1
        If Mid(s, 1, Len(optrs.optr(i))) = optrs.optr(i) Then
            l = l + 1
            ReDim Preserve s1(l) As String
            s1(l) = optrs.optr(i)
        End If
    Next i
    
    If l = -1 Then
        optr = ""
        length = 0
        ParseOperator = False
    Else
        max = 0
        For i = 1 To l Step 1
            If Len(s1(i)) > Len(s1(max)) Then
                max = i
            End If
        Next i
        optr = s1(max)
        length = Len(s1(max)) + (Len(tmp) - Len(s))
        ParseOperator = True
    End If
    
End Function

Public Function IsDigit(d As String) As Boolean
    If d = "0" Or d = "1" Or d = "2" Or d = "3" Or d = "4" Or d = "5" Or d = "6" Or d = "7" Or d = "8" Or d = "9" Then
        IsDigit = True
    Else
        IsDigit = False
    End If
End Function

Public Function ParseOperand(ByVal s As String, oprnd As String, length As Long, optrs As operators, fs As functions, prefix As functions, postfix As functions) As Boolean
Dim tmp As String
Dim tmp1 As String
Dim oprnd1 As String
Dim oprnd2 As String
Dim optr1 As String
Dim length1 As Long
Dim length2 As Long
Dim length3 As Long
Dim dotflg As Boolean
Dim dgtflg As Boolean
Dim bcnt As Long
Dim i As Long
Dim oldi As Long

s = LCase(s)
tmp1 = s
s = LTrim(s)

If s = "" Then
    oprnd = ""
    length = 0
    ParseOperand = False
    Exit Function
End If

If ParseFunction(s, oprnd1, length1, prefix) Then
    If ParseOperand(Mid(s, length1 + 1, Len(s) - length1), oprnd2, length2, optrs, fs, prefix, postfix) Then
        oprnd = oprnd1 & oprnd2
        length = length1 + length2 + (Len(tmp1) - Len(s))
        ParseOperand = True
    Else
        oprnd = ""
        length = 0
        ParseOperand = False
    End If
    Exit Function
End If
        
 
If Mid(s, 1, 1) = "(" Then
    bcnt = 1
    i = 1
    Do Until (bcnt <= 0 Or i > Len(s))
        i = i + 1
        If i <= Len(s) Then
            If Mid(s, i, 1) = "(" Then
                bcnt = bcnt + 1
            ElseIf Mid(s, i, 1) = ")" Then
                bcnt = bcnt - 1
            End If
        End If
    Loop
    i = IIf(i > Len(s), Len(s), i)
    If bcnt <> 0 Then
        oprnd = ""
        length = 0
        ParseOperand = False
    ElseIf ParseEntireExpression(Mid(s, 2, i - 2), oprnd1, length1, optrs, fs, prefix, postfix) Then
            oprnd = "(" & oprnd1 & ")"
            length = 2 + length1 + (Len(tmp1) - Len(s))
            s = Mid(s, IIf(i + 1 <= Len(s), i + 1, Len(s)), IIf(i + 1 <= Len(s), Len(s) - i, 0))
            While s <> "" And ParsePostFix(s, oprnd1, length2, s, postfix)
                length = length + length2
                oprnd = oprnd & oprnd1
            Wend
            ParseOperand = True
    Else
        oprnd = ""
        length = 0
        ParseOperand = False
    End If
    Exit Function
End If

i = 1
dotflg = False
dgtflg = False
While i <= Len(s)
    If Mid(s, i, 1) = " " Then
        If dgtflg Then
            If ParseNumber(Mid(s, i + 1, Len(s) - i), oprnd1, length1) Then
                oprnd = ""
                length = 0
                ParseOperand = False
                Exit Function
            Else
                dotflg = False
            End If
        End If
        i = i + 1
    ElseIf Mid(s, i, 1) = "(" Then
        If oldi <> 0 Then
            If IsDigit(Mid(s, oldi, 1)) Or Mid(s, oldi, 1) = "." Then
                oprnd = ""
                length = 0
                ParseOperand = False
                Exit Function
            End If
        End If
        If ParseOperand(Mid(s, i, Len(s) - i + 1), oprnd1, length1, optrs, fs, prefix, postfix) Then
            oldi = i
            i = i + length1
            dgtflg = False
            dotflg = False
        Else
            oprnd = ""
            length = 0
            ParseOperand = False
            Exit Function
        End If
    ElseIf Mid(s, i, 1) = "." Then
        If dotflg Then
            oprnd = ""
            length = 0
            ParseOperand = False
            Exit Function
        End If
        dgtflg = True
        oldi = i
        i = i + 1
        dotflg = True
    ElseIf IsDigit(Mid(s, i, 1)) Then
        oldi = i
        dgtflg = True
        i = i + 1
    ElseIf ParseFunction(Mid(s, i, Len(s) - i + 1), oprnd1, length1, fs) Then
        If oldi <> 0 Then
            If Not ParseOperator(Mid(s, oldi, i - oldi), optr1, length2, optrs) Then
                If Not ParseFunction(Mid(s, oldi, i - oldi), optr1, length2, fs) Then
                    oprnd = ""
                    length = 0
                    ParseOperand = False
                    Exit Function
                ElseIf Trim(Mid(s, oldi, i - oldi)) <> Trim(optr1) Then
                    oprnd = ""
                    length = 0
                    ParseOperand = False
                    Exit Function
                End If
            ElseIf Trim(Mid(s, oldi, i - oldi)) <> Trim(optr1) Then
                If Not ParseFunction(Mid(s, oldi, i - oldi), optr1, length2, fs) Then
                    oprnd = ""
                    length = 0
                    ParseOperand = False
                    Exit Function
                ElseIf Trim(Mid(s, oldi, i - oldi)) <> Trim(optr1) Then
                    oprnd = ""
                    length = 0
                    ParseOperand = False
                    Exit Function
                End If
             End If
        End If
        oldi = i
        i = i + length1
        If Not ParseOperand(Mid(s, i, Len(s) - i + 1), oprnd1, length1, optrs, fs, prefix, postfix) Then
            oprnd = ""
            length = 0
            ParseOperand = False
            Exit Function
        Else
            oldi = i
            i = i + length1
        End If
        dgtflg = False
        dotflg = False
    ElseIf ParseFunction(Mid(s, i, Len(s) - i + 1), oprnd1, length1, postfix) Then
        If oldi <> 0 Then
            If Not ParseOperand(Mid(s, oldi, i - oldi), oprnd2, length2, optrs, fs, prefix, postfix) Then
                oprnd = ""
                length = 0
                ParseOperand = False
                Exit Function
            ElseIf Trim(Mid(s, oldi, i - oldi)) <> Trim(oprnd2) Then
                oprnd = ""
                length = 0
                ParseOperand = False
                Exit Function
            End If
        Else
            oprnd = ""
            length = 0
            ParseOperand = False
            Exit Function
        End If
        oldi = i
        i = i + length1
        While i <= Len(s) And ParseFunction(Mid(s, IIf(i > Len(s), Len(s), i), IIf(i <= Len(s), Len(s) - i + 1, 0)), oprnd1, length1, postfix)
            oldi = i
            i = i + length1
        Wend
        If i > Len(s) Then
            oprnd = s
            length = (i - 1) + (Len(tmp1) - Len(s))
            ParseOperand = True
            Exit Function
        ElseIf Not ParseOperator(Mid(s, i, Len(s) - i + 1), optr1, length2, optrs) Then
            oprnd = ""
            length = 0
            ParseOperand = False
            Exit Function
        Else
            oprnd = Mid(s, 1, i - 1)
            length = i - 1 + (Len(tmp1) - Len(s))
            ParseOperand = True
            Exit Function
        End If
    ElseIf ParseOperator(Mid(s, i, Len(s) - i + 1), optr1, length2, optrs) Then
        If oldi <> 0 Then
            If Not ParseOperand(Mid(s, oldi, i - oldi), oprnd1, length1, optrs, fs, prefix, postfix) Then
                oprnd = ""
                length = 0
                ParseOperand = False
                Exit Function
            ElseIf Trim(Mid(s, oldi, i - oldi)) <> Trim(oprnd1) Then
                oprnd = ""
                length = 0
                ParseOperand = False
                Exit Function
            End If
        End If
        oprnd = Mid(s, 1, i - 1)
        length = i - 1 + (Len(tmp1) - Len(s))
        ParseOperand = True
        Exit Function
    Else
        oprnd = ""
        length = 0
        ParseOperand = False
        Exit Function
    End If
Wend

i = i - 1
If i = Len(s) Then
    oprnd = s
    length = i + (Len(tmp1) - Len(s))
    ParseOperand = True
Else
    oprnd = ""
    length = 0
    ParseOperand = False
End If

End Function

Public Function ParseEntireExpression(ByVal s As String, expr As String, length As Long, optrs As operators, funs As functions, prefix As functions, postfix As functions) As Boolean
Dim l As Long
Dim l1 As Long
Dim l2 As Long
Dim tmp As String
Dim tmp1 As String
Dim tmp2 As String

    s = LCase(s)
    If ParseOperand(s, tmp, l, optrs, funs, prefix, postfix) Then
        If Trim(tmp) = Trim(s) Then
            expr = s
            length = Len(s)
            ParseEntireExpression = True
            Exit Function
        Else
            tmp = Mid(s, l + 1, Len(s) - l + 1)
            length = l
            While tmp <> ""
                If ParseOperator(tmp, tmp1, l1, optrs) Then
                    tmp = Mid(tmp, l1 + 1, Len(tmp) - l1 + 1)
                    length = length + l1
                Else
                    expr = ""
                    length = 0
                    ParseEntireExpression = False
                    Exit Function
                End If
                
                If ParseOperand(tmp, tmp2, l2, optrs, funs, prefix, postfix) Then
                    tmp = Mid(tmp, l2 + 1, Len(tmp) - l2 + 1)
                    length = length + l2
                Else
                    expr = ""
                    length = 0
                    ParseEntireExpression = False
                    Exit Function
                End If
            Wend
            expr = s
            ParseEntireExpression = True
            Exit Function
        End If
    Else
        expr = ""
        length = 0
        ParseEntireExpression = False
    End If
End Function


Public Function Evaluate_Expression(ByVal s As String, fs As functions, optrs As operators, prefix As functions, postfix As functions, valid As Boolean, RadDegGrad As String) As Variant
Dim original As String
Dim op1 As String
Dim op2 As String
Dim vop1 As String
Dim vop2 As String
Dim opr1 As String
Dim f1 As String
Dim f2 As String
Dim l1 As Long
Dim l2 As Long
Dim tmp As String
Dim sflg As Long
Dim nl As Long
Dim bflg As Boolean
Dim flg1 As Boolean
Dim flg2 As Boolean
Dim res As Variant
Dim opstk As stack
Dim oprstk As stack
    
    original = s
    s = LTrim(LCase(s))
    If ParseOperand(s, op1, l1, optrs, fs, prefix, postfix) Then
        If s = op1 Then
            If ParseFunction(s, f1, l2, prefix) Then
                tmp = Mid(s, l2 + 1, Len(s) - l2)
                res = Evaluate_Expression(tmp, fs, optrs, prefix, postfix, bflg, RadDegGrad)
                If Not bflg Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                End If
                valid = True
                Evaluate_Expression = Evaluate_PreFix(f1, CDbl(res), prefix)
                Exit Function
            ElseIf Mid(s, 1, 1) = "(" Then
                nl = FindNestingLength(s, bflg)
                If Not bflg Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                End If
                res = Evaluate_Expression(Mid(s, 2, nl - 2), fs, optrs, prefix, postfix, bflg, RadDegGrad)
                If Not bflg Then
                    valid = False
                    Evaluate_Expression = 0#
                Else
                    s = Mid(s, nl + 1, Len(s) - nl)
                    While Trim(s) <> "" And ParsePostFix(s, f2, l2, s, postfix)
                        res = Evaluate_PostFix(CDbl(res), f2, postfix)
                    Wend
                    If Trim(s) <> "" Then
                        valid = False
                        Evaluate_Expression = 0#
                        Exit Function
                    Else
                        Evaluate_Expression = res
                        valid = True
                        Exit Function
                    End If
                End If
            ElseIf ParseFunction(s, f1, l2, fs) Then
                tmp = Mid(s, l2 + 1, Len(s) - l2)
                res = Evaluate_Expression(tmp, fs, optrs, prefix, postfix, bflg, RadDegGrad)
                If Not bflg Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                End If
                valid = True
                Evaluate_Expression = Evaluate_Function(f1, fs, CDbl(res), RadDegGrad)
                Exit Function
            Else
                If Not ParseNumber(s, f1, l2) Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                ElseIf Trim(s) = Trim(f1) Then
                    Evaluate_Expression = CVar(Val(f1))
                    valid = True
                    Exit Function
                End If
                s = Mid(s, l2 + 1, Len(s) - l2)
                res = CDbl(f1)
                While Trim(s) <> "" And ParsePostFix(s, f2, l2, s, postfix)
                    res = Evaluate_PostFix(CDbl(res), f2, postfix)
                Wend
                If Trim(s) <> "" Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                Else
                    Evaluate_Expression = res
                    valid = True
                    Exit Function
                End If
            End If
        Else
            Call InitiateStack(opstk)
            Call InitiateStack(oprstk)
            Call push(opstk, op1)
            s = Mid(s, l1 + 1, Len(s) - l1)
            While s <> ""
                If Not ParseOperator(s, opr1, l1, optrs) Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                End If
                If StackTopItem(oprstk) = "NULL" Then
                    Call push(oprstk, opr1)
                ElseIf OperatorPriority(StackTopItem(oprstk), optrs) < OperatorPriority(opr1, optrs) Then
                    Call push(oprstk, opr1)
                Else
                    While (Not StackEmpty(oprstk)) And (OperatorPriority(StackTopItem(oprstk), optrs) >= OperatorPriority(opr1, optrs))
                        op2 = pop(opstk)
                        op1 = pop(opstk)
                        If op1 = "NULL" Or op2 = "NULL" Then
                            valid = False
                            Evaluate_Expression = 0#
                            Exit Function
                        End If
                        vop1 = Evaluate_Expression(op1, fs, optrs, prefix, postfix, flg1, RadDegGrad)
                        vop2 = Evaluate_Expression(op2, fs, optrs, prefix, postfix, flg2, RadDegGrad)
                        If Not flg1 Or Not flg2 Then
                            valid = False
                            Evaluate_Expression = 0#
                            Exit Function
                        End If
                        Call push(opstk, CStr(Evaluate_Operators(vop1, pop(oprstk), vop2, optrs)))
                    Wend
                    Call push(oprstk, opr1)
                End If
                s = Mid(s, l1 + 1, Len(s) - l1)
                If Not ParseOperand(s, op2, l2, optrs, fs, prefix, postfix) Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                End If
                Call push(opstk, op2)
                s = Mid(s, l2 + 1, Len(s) - l2)
            Wend
            While Not StackEmpty(oprstk)
                op2 = pop(opstk)
                op1 = pop(opstk)
                If op1 = "NULL" Or op2 = "NULL" Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                End If
                vop1 = Evaluate_Expression(op1, fs, optrs, prefix, postfix, flg1, RadDegGrad)
                vop2 = Evaluate_Expression(op2, fs, optrs, prefix, postfix, flg2, RadDegGrad)
                If Not flg1 Or Not flg2 Then
                    valid = False
                    Evaluate_Expression = 0#
                    Exit Function
                End If
                Call push(opstk, CStr(Evaluate_Operators(vop1, pop(oprstk), vop2, optrs)))
            Wend
            res = CVar(pop(opstk))
            If Not StackEmpty(opstk) Or Not StackEmpty(oprstk) Then
                valid = False
                Evaluate_Expression = 0#
                Exit Function
            Else
                valid = True
                Evaluate_Expression = res
            End If
        End If
    Else
        valid = False
        Evaluate_Expression = 0#
    End If
End Function


Public Function FindNestingLength(ByVal s As String, valid As Boolean) As Long
Dim i As Long
Dim bcnt As Long
Dim tmp As String

    tmp = s
    s = LTrim(s)
    
    If Mid(s, 1, 1) <> "(" Then
        valid = False
        FindNestingLength = 0
        Exit Function
    End If
    
    i = 1
    bcnt = 1
    Do Until bcnt <= 0 Or i > Len(s)
        i = i + 1
        If i <= Len(s) Then
            If Mid(s, i, 1) = "(" Then
                bcnt = bcnt + 1
            ElseIf Mid(s, i, 1) = ")" Then
                bcnt = bcnt - 1
            End If
        End If
    Loop
    
    If bcnt <> 0 Then
        valid = False
        FindNestingLength = 0
    Else
        valid = True
        FindNestingLength = IIf(i > Len(s), Len(s), i)
    End If
        
End Function

Public Function DegToRad(deg As Variant) As Variant
    DegToRad = deg * 0.017453292
End Function

Public Function GradToRad(grd As Variant) As Variant
    GradToRad = grd * 0.015707963
End Function

Public Function RadToDeg(rad As Variant) As Variant
    RadToDeg = rad * 57.29577951
End Function

Public Function RadToGrad(rad As Variant) As Variant
    RadToGrad = rad * 63.66197724
End Function

Public Function Factorial(ByVal n As Long) As Double
    
    If n < 0 Then
       n = 1# / 0
       n = -n
    End If
    
    If n = 0 Then
        Factorial = 1#
    Else
        Factorial = n * Factorial(n - 1)
    End If
    
End Function

Public Function nCr(n As Long, r As Long) As Double
     nCr = Factorial(n) / (Factorial(r) * Factorial(n - r))
End Function

Public Function nPr(n As Long, r As Long) As Double
    nPr = Factorial(n) / Factorial(n - r)
End Function

Public Function PreProcessor(ByVal s As String, mem As memory) As String
Dim i As Long
Dim tmp As String
Dim wrd As String
Dim l1 As Long
Dim j As Long
    
    tmp = ""
    Do While s <> ""
        If ParseWordUpper(s, wrd, l1) Then
            For i = 0 To mem.cnt - 1 Step 1
                If wrd = mem.nam(i) Then
                    tmp = tmp & " " & mem.value(i) & " "
                    s = Mid(s, l1 + 1, Len(s) - l1)
                    Exit For
                End If
            Next i
            If i = mem.cnt Then
                tmp = tmp & Mid(s, 1, l1)
                s = Mid(s, l1 + 1, Len(s) - l1)
            End If
        Else
            tmp = tmp & Mid(s, 1, 1)
            s = Mid(s, 2, Len(s) - 1)
        End If
    Loop
    PreProcessor = tmp
End Function

Public Function ParseNumber(ByVal s As String, dgtpd As String, length As Long) As Boolean
Dim tmp As String
Dim dotflg As Boolean
Dim i As Long

tmp = s
s = LTrim(s)
If s = "" Then
    dgtpd = ""
    length = 0
    ParseNumber = False
    Exit Function
End If
If Not IsDigit(Mid(s, 1, 1)) And Mid(s, 1, 1) <> "." Then
    dgtpd = ""
    length = 0
    ParseNumber = False
    Exit Function
End If


If Mid(s, 1, 1) = "." Then
    dotflg = True
Else
    dotflg = False
End If

i = 2
If i >= 2 Then
    While i <= Len(s) And IIf(i > Len(s), False, IIf(IsDigit(Mid(s, i, 1)), True, IIf(Mid(s, i, 1) <> ".", False, IIf(dotflg, False, True))))
        If Mid(s, i, 1) = "." Then
            dotflg = True
        End If
        i = i + 1
    Wend
End If
    
i = i - 1
length = i + (Len(tmp) - Len(s))
dgtpd = Mid(s, 1, i)
ParseNumber = True
End Function

Public Function ParseWord(ByVal s As String, word As String, length As Long) As Boolean
Dim tmp As String
Dim i As Long

tmp = s
s = LTrim(s)
If s = "" Or Not IsAlpha(Mid(s, 1, 1)) Then
    word = ""
    length = 0
    ParseWord = False
    Exit Function
End If
i = 2
If Len(s) >= 2 Then
    While i <= Len(s) And IIf(i > Len(s), False, IsAlpha(Mid(s, i, 1)))
        i = i + 1
    Wend
End If
i = i - 1
length = i + (Len(tmp) - Len(s))
word = Mid(s, 1, i)
ParseWord = True
End Function

Public Function IsAlpha(s As String) As Boolean
Dim i As Long
    
    If s = "" Then
        IsAlpha = False
        Exit Function
    End If
    i = Asc(Mid(s, 1, 1))
    If i >= 65 And i <= 90 Then
        IsAlpha = True
    ElseIf i >= 97 And i <= 122 Then
        IsAlpha = True
    Else
        IsAlpha = False
    End If

End Function

Public Function IsAlphaUpper(s As String) As Boolean
Dim i As Long
    
    If s = "" Then
        IsAlphaUpper = False
        Exit Function
    End If
    i = Asc(Mid(s, 1, 1))
    If i >= 65 And i <= 90 Then
        IsAlphaUpper = True
    Else
        IsAlphaUpper = False
    End If
    
End Function

Public Function ParseWordUpper(ByVal s As String, word As String, length As Long) As Boolean
Dim tmp As String
Dim i As Long

tmp = s
s = LTrim(s)
If s = "" Or Not IsAlphaUpper(Mid(s, 1, 1)) Then
    word = ""
    length = 0
    ParseWordUpper = False
    Exit Function
End If
i = 2
If Len(s) >= 2 Then
    While i <= Len(s) And IIf(i > Len(s), False, IsAlphaUpper(Mid(s, i, 1)))
        i = i + 1
    Wend
End If
i = i - 1
length = i + (Len(tmp) - Len(s))
word = Mid(s, 1, i)
ParseWordUpper = True
End Function

Public Function ParsePostFix(ByVal s As String, parsed As String, length As Long, remain As String, postfixes As functions) As Boolean
    If ParseFunction(s, parsed, length, postfixes) Then
        remain = Mid(s, length + 1, Len(s) - length)
        ParsePostFix = True
    Else
        remain = s
        ParsePostFix = False
    End If
End Function

Public Function StoreRef(ByVal expr As String, toeval As String, mem As memory) As Long
Dim i As Long
Dim store As String

        i = FindStore(expr)
        If i > 0 Then
            store = Mid(expr, i + 2, Len(expr) - i - 1)
            toeval = Left(expr, i - 1)
            If Trim(store) = "" Then store = ""
        Else
            toeval = expr
            store = ""
        End If
        If store <> "" Then
                For i = 0 To mem.cnt - 1 Step 1
                    If Trim(store) = Trim(mem.nam(i)) Then
                        StoreRef = i
                        Exit Function
                    End If
                Next i
        End If
        StoreRef = -1
End Function

Public Function FindStore(s As String) As Long
Dim i As Long

i = Len(s) - 1
While i >= 1
    If Mid(s, i, 2) = "->" Then
        FindStore = i
        Exit Function
    End If
    i = i - 1
Wend
FindStore = 0
End Function



