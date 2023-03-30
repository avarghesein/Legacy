Attribute VB_Name = "rational"
Option Explicit

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

'---------------remove to change demo
Public time1 As Date
Public time2 As Date
'----------------------------------------

Type rat
    a As Currency
    b As Currency
End Type

Type matrix
    matx() As rat
    rows As Long
    cols As Long
    rank As Long
    id_ As Long
End Type

Public tmp1_matx As matrix
Public tmp2_matx As matrix
Public tmp_rat As rat

Type epsilon
    e As Double
    n As Double
End Type

Type point
    x As Double
    Y As Double
End Type

Type xy_plane
    x_centre As Double
    y_centre As Double
    x_axis_len As Double
    y_axis_len As Double
    x_max As Double
    y_max As Double
    xinc As Double
    yinc As Double
End Type

Public Function map_pointto_xyplane(p As point, xyp As xy_plane) As point
Dim tmp As point

tmp.x = xyp.x_centre + xyp.x_axis_len * (p.x / xyp.x_max)
tmp.Y = xyp.y_centre - xyp.y_axis_len * (p.Y / xyp.y_max)
map_pointto_xyplane = tmp

End Function

Public Sub map_xycentreto_object(xyp As xy_plane, pic As Object)
    xyp.y_centre = pic.ScaleHeight - xyp.y_centre
End Sub

Public Function Isfractional(x As Double) As Boolean
Dim i As Integer
Dim tmp As String

tmp = Trim(str(Round(x, 12)))

For i = 1 To Len(tmp) Step 1
    If Mid(tmp, i, 1) = "." Then
        Isfractional = True
        Exit Function
    End If
Next i

Isfractional = False

End Function

Public Function rat_real(stg As String) As Double
Dim r As rat
Dim a As Double
Dim b As Double

r = string_rat(stg)
a = r.a
b = r.b

If b <> 0 Then
    rat_real = Round(a / b, 8)
Else
    rat_real = 0
End If

End Function

Public Function is_subpattern_repeating(s As String, ByVal indx As Long, exact_match As Boolean) As Boolean
Dim first As String

 If Len(s) < indx Then
        is_subpattern_repeating = False
        Exit Function
End If
first = Mid(s, indx, Len(s) - indx + 1)
is_subpattern_repeating = is_pattern_repeating(first, 2, exact_match)
End Function

Public Function is_subpattern_repeating_low(s As String, ByVal indx As Long, exact_match As Boolean) As Boolean
Dim first As String

 If Len(s) < indx Then
        is_subpattern_repeating_low = False
        Exit Function
End If
first = Mid(s, indx, Len(s) - indx + 1)
is_subpattern_repeating_low = is_pattern_repeating_low(first, 2, exact_match)
End Function

Public Function is_pattern_repeating_low(s As String, ByVal interval As Long, exact_match As Boolean) As Boolean
Dim i As Long
Dim first As String
Dim tmp As String

    If Len(s) < interval Then
        is_pattern_repeating_low = False
        Exit Function
    End If
    first = Mid(s, 1, interval)
    i = interval + 1
    While i <= Len(s)
        tmp = Mid(s, i, interval)
        If exact_match Or (Not exact_match And Len(tmp) >= Len(first)) Then
            If tmp <> first Then
                is_pattern_repeating_low = False
                Exit Function
            End If
        End If
        i = i + interval
    Wend
    is_pattern_repeating_low = True
End Function

Public Function is_pattern_repeating(s As String, ByVal interval As Long, exact_match As Boolean) As Boolean
Dim i As Long
Dim first As String
Dim tmp As String
Dim cflg As Boolean

    If Len(s) < interval Then
        is_pattern_repeating = False
        Exit Function
    End If
    first = Mid(s, 1, interval)
    i = interval + 1
    cflg = True
    Do
        tmp = Mid(s, i, interval)
        If cflg Or (exact_match Or (Not exact_match And Len(tmp) >= Len(first))) Then
            If tmp <> first Then
                is_pattern_repeating = False
                Exit Function
            End If
            cflg = False
        End If
        i = i + interval
    Loop While i <= Len(s)
    is_pattern_repeating = True
End Function


Public Function real_rat(num As Double, Optional ByVal accuracy As Double) As String
Dim i As Long
Dim j As Long
Dim clng_part As String
Dim dec_part As String
Dim i1 As String
Dim i2 As String
Dim i3 As String
Dim Y As String
Dim r As rat
Dim flg As Boolean
Dim ipart As Currency
Dim sign_ As Integer
Dim dec As Double
Dim dprev As Double
Dim dcur As Double
Dim tmp As Double
Dim z As Double
Dim n As Double

sign_ = IIf(num < 0, -1, 1)

Y = Trim(str(Abs(num)))
i = search_string(Y, ".")

If i <> -1 Then
    clng_part = Mid(Y, 1, i - 1)
    dec_part = Mid(Y, i + 1, Len(Y) - i)
    dec = Val(Mid(Y, i, Len(Y) - i + 1))
Else
    clng_part = Y
    dec_part = ""
End If

If i = -1 Or Len(dec_part) <= 3 Then
    i1 = dec_part
    i2 = "1"
    For i = 1 To Len(dec_part) Step 1
        i2 = i2 + "0"
    Next i
Else
    Y = Mid(dec_part, 1, IIf(Len(dec_part) <= 8, Len(dec_part), 8))
    i1 = Mid(Y, 1, 1)
    flg = True
    For j = 2 To Len(Y) Step 1
        If Mid(Y, j, 1) <> i1 Then
            flg = False
            Exit For
        End If
    Next j
    If flg Then
        i1 = Mid(Y, 1, 2)
        i2 = "99"
    Else
        If is_pattern_repeating_low(Y, 2, False) Then
            i1 = Mid(Y, 1, 2)
            i2 = "99"
        ElseIf is_pattern_repeating_low(Y, 3, False) Then
            i1 = Mid(Y, 1, 3)
            i2 = "999"
        ElseIf is_subpattern_repeating_low(Y, 2, False) Then
            i1 = Trim(str(Val(Mid(Y, 1, 2)) - Val(Mid(Y, 1, 1))))
            i2 = "90"
        ElseIf is_subpattern_repeating_low(Y, 3, False) Then
            i1 = Trim(str(Val(Mid(Y, 1, 3)) - Val(Mid(Y, 1, 2))))
            i2 = "900"
        Else
            If IsMissing(accuracy) Or accuracy = 0 Then
                accuracy = 0.00001
            End If
            dprev = 0
            dcur = 1
            z = dec
            Do
                z = Round(1# / (z - CLng(z)), 12)
                tmp = dcur
                dcur = dcur * CLng(z) + dprev
                dprev = tmp
                n = Round(dec * dcur + 0.5)
            Loop Until (Abs((dec - (n / dcur))) < accuracy Or z = CLng(z))
            r.a = sign_ * n
            r.b = dcur
            r.a = r.b * Val(clng_part) * sign_ + r.a
            '--------------------r.b=r.b
            r = ratred(r)
            real_rat = rat_stg(r)
            Exit Function
        End If
    End If
End If
r.a = CCur(Round(Val(i1) * sign_, 0))
r.b = CCur(Round(Val(i2), 0))
r = ratred(r)
ipart = CCur(Round(Val(clng_part), 0)) * sign_
r.a = ipart * r.b + r.a '--------a(b/c)=(a*c+b)/c
                        '--------r.b=r.b
real_rat = rat_stg(r)
End Function

Public Function search_string(stg As String, char As String) As Integer
Dim i As Integer
Dim len_sub As Integer
Dim tmp1 As String
Dim tmp2 As String

tmp1 = Trim(stg)
tmp2 = Trim(char)
len_sub = Len(tmp2)

If len_sub = 0 Or Len(tmp1) < len_sub Then
    search_string = -1
    Exit Function
End If

For i = 1 To Len(tmp1) Step 1
    If Mid(tmp1, i, len_sub) = tmp2 Then
        search_string = i
        Exit Function
    End If
Next i

search_string = -1
End Function

Public Function rat_reminder(rational As rat) As Currency
Dim r As rat
Dim divi As Currency
Dim t1 As String
        Dim i As Long
        r = rational
        If r.a < 0 Then r.a = -r.a
        If r.b < 0 Then r.b = -r.b
        If r.a < r.b Then
            divi = r.a
            r.a = r.b
            r.b = divi
        End If
        If r.b <> 0 Then
               t1 = Trim(str(r.a / r.b))
               i = search_string(t1, ".")
               If i <> -1 Then
                    divi = Val(Mid(t1, 1, i - 1))
               Else
                    divi = Val(t1)
               End If
        Else
                divi = 0
        End If
        rat_reminder = r.a - divi * r.b
End Function

Public Function lcm(x As Currency, Y As Currency) As Currency
Dim t As rat
Dim gcd_ As Currency

    t.a = x
    t.b = Y
    gcd_ = gcd(t)
    lcm = IIf(x = gcd_, (x / gcd_) * Y, x * (Y / gcd_))
End Function

Public Function gcd(r As rat) As Currency
Dim r1 As rat
Dim t1 As Currency

Call proper_sign(r)

r1.a = r.a
r1.b = r.b

If r1.b = 0 Then
    gcd = 1
    Exit Function
End If

If r1.a < 0 Then r1.a = -r1.a
If r1.b < 0 Then r1.b = -r1.b
If r1.a < r1.b Then
    t1 = r1.b
    r1.b = r1.a
    r1.a = t1
End If

While r1.b > 0
    t1 = rat_reminder(r1) 'r1.a Mod r1.b
    r1.a = r1.b
    r1.b = t1
Wend

gcd = r1.a
End Function

Public Function ratred(r As rat) As rat
Dim gcd_ As Currency
Dim r1 As rat
    
    gcd_ = gcd(r)
    r1.a = r.a / gcd_
    r1.b = r.b / gcd_

ratred = r1
End Function

Public Function string_rat(stg As String) As rat
Dim a As rat
Dim b As rat
Dim indx As Integer
Dim tmp As String
Dim r As rat

indx = search_string(stg, "/")
If indx = -1 Then
    tmp = real_rat(Val(stg))
    indx = search_string(tmp, "/")
    If indx = -1 Then
        r.a = Int(Val(tmp))
        r.b = 1
    Else
        r.a = Int(Val(Mid(tmp, 1, indx - 1)))
        r.b = Int(Val(Mid(tmp, indx + 1, Len(tmp) - indx)))
    End If
Else
    a = string_rat(Mid(stg, 1, indx - 1))
    b = string_rat(Mid(stg, indx + 1, Len(stg) - indx))
    tmp = ratdiv(rat_stg(a), rat_stg(b))
    indx = search_string(tmp, "/")
    If indx = -1 Then
        r.a = Int(Val(tmp))
        r.b = 1
    Else
        r.a = Int(Val(Mid(tmp, 1, indx - 1)))
        r.b = Int(Val(Mid(tmp, indx + 1, Len(tmp) - indx)))
        If r.b = 0 Then
            MsgBox "X"
        End If
     End If
End If

r = ratred(r)
string_rat = r
End Function

Public Function rat_abs(stg As String) As String
Dim r1 As rat
    r1 = string_rat(stg)
    r1.a = Abs(r1.a)
    r1.b = Abs(r1.b)
rat_abs = rat_stg(r1)
End Function
Public Function ratadd(stg1 As String, stg2 As String) As String
Dim r1 As rat
Dim r2 As rat
Dim r3 As rat
Dim lcm_ As Currency

r1 = string_rat(stg1)
r2 = string_rat(stg2)

Call proper_sign(r1)
Call proper_sign(r2)

lcm_ = lcm(r1.b, r2.b)

r3.a = r1.a * (lcm_ / r1.b) + r2.a * (lcm_ / r2.b)
r3.b = lcm_

r3 = ratred(r3)

ratadd = rat_stg(r3)
End Function

Public Function ratsub(stg1 As String, stg2 As String) As String
Dim r1 As rat
Dim r2 As rat
Dim r3 As rat
Dim lcm_ As Currency

r1 = string_rat(stg1)

r2 = string_rat(stg2)
Call proper_sign(r1)
Call proper_sign(r2)

lcm_ = lcm(r1.b, r2.b)

r3.a = r1.a * (lcm_ / r1.b) - r2.a * (lcm_ / r2.b)
r3.b = lcm_

r3 = ratred(r3)

ratsub = rat_stg(r3)
End Function

Public Function ratmul(stg1 As String, stg2 As String) As String
Dim r1 As rat
Dim r2 As rat
Dim r3 As rat
Dim tmp As Variant

r1 = string_rat(stg1)
r2 = string_rat(stg2)

Call proper_sign(r1)
Call proper_sign(r2)

tmp = r1.b
r1.b = r2.b
r2.b = tmp

r1 = ratred(r1)
r2 = ratred(r2)

r3.a = r1.a * r2.a
r3.b = r1.b * r2.b

r3 = ratred(r3)

ratmul = rat_stg(r3)
End Function

Public Function ratdiv(stg1 As String, stg2 As String) As String
Dim r1 As rat
Dim r2 As rat
Dim r3 As rat
Dim tmp As Variant

r1 = string_rat(stg1)
r2 = string_rat(stg2)

Call proper_sign(r1)
Call proper_sign(r2)

If r2.a <> 0 Then
    tmp = r1.b
    r1.b = r2.a
    r2.a = tmp
    r1 = ratred(r1)
    r2 = ratred(r2)
    r3.a = r1.a * r2.b
    r3.b = r1.b * r2.a
Else
    r3.a = 0
    r3.b = 1
End If

r3 = ratred(r3)

ratdiv = rat_stg(r3)
End Function

Public Function rat_eq0(stg As String) As Boolean

    rat_eq0 = rat1_rel_rat2(stg, "=", "0")

End Function

Public Function rat_neq0(stg As String) As Boolean

    rat_neq0 = rat1_rel_rat2(stg, "<>", "0")

End Function


Private Sub proper_sign(r As rat)

If (r.a > 0 And r.b < 0) Or (r.a < 0 And r.b < 0) Then
    r.a = -r.a
    r.b = -r.b
End If
    
End Sub

Public Function rat_leq0(stg As String) As Boolean

    rat_leq0 = rat1_rel_rat2(stg, "<=", "0")

End Function

Public Function rat_geq0(stg As String) As Boolean

    rat_geq0 = rat1_rel_rat2(stg, ">=", "0")

End Function


Public Function rat_less0(stg As String) As Boolean

    rat_less0 = rat1_rel_rat2(stg, "<", "0")

End Function

Public Function rat_gret0(stg As String) As Boolean
    
    rat_gret0 = rat1_rel_rat2(stg, ">", "0")

End Function

Public Function rat_rat(stg As String) As Boolean
Dim r As rat

r = string_rat(stg)
Call proper_sign(r)

If r.a = 0 Or r.b = 1 Or r.b = 0 Then
    rat_rat = False
Else
    rat_rat = True
End If
End Function

Public Function rat_intpart(r As rat) As Integer
Dim x As Double
Dim Y As Double
Dim tmp As String
Dim indx As Integer

x = r.a
Y = r.b

x = Round((r.a / r.b), 12)
tmp = Trim(str(x))
indx = search_string(tmp, ".")
If indx <> -1 Then
    tmp = Mid(tmp, 1, indx - 1)
End If
rat_intpart = Val(Trim(tmp))

End Function
Public Function rat_properfractional(stg As String) As String
Dim r As rat
Dim r1 As rat
Dim x As Double
Dim Y As Double

r = string_rat(stg)
Call proper_sign(r)
r = ratred(r)
If r.b <> 0 Then
    If r.a > 0 Then
        r1.a = r.a - rat_intpart(r) * r.b
        r1.b = r.b
    Else
        r1.a = r.a + (Abs(rat_intpart(r)) + 1) * r.b
        r1.b = r.b
    End If
    r1 = ratred(r1)
Else
    r1.a = 0
    r1.b = 1
End If

rat_properfractional = rat_stg(r1)
End Function

Public Function rat_stg(r As rat) As String
    rat_stg = Trim(str(r.a)) & IIf(r.b = 1 Or r.a = 0, "", "/" & Trim(str(r.b)))
End Function

Public Function rat1_leq_rat2(stg1 As String, stg2 As String) As Boolean

    rat1_leq_rat2 = rat1_rel_rat2(stg1, "<=", stg2)

End Function

Public Function rat1_geq_rat2(stg1 As String, stg2 As String) As Boolean

    rat1_geq_rat2 = rat1_rel_rat2(stg1, ">=", stg2)

End Function

Public Function rat1_less_rat2(stg1 As String, stg2 As String) As Boolean

    rat1_less_rat2 = rat1_rel_rat2(stg1, "<", stg2)

End Function


Public Function rat1_gret_rat2(stg1 As String, stg2 As String) As Boolean

    rat1_gret_rat2 = rat1_rel_rat2(stg1, ">", stg2)

End Function

Public Function rat1_equ_rat2(stg1 As String, stg2 As String) As Boolean

    rat1_equ_rat2 = rat1_rel_rat2(stg1, "=", stg2)

End Function

Public Function rat1_neq_rat2(stg1 As String, stg2 As String) As Boolean

    rat1_neq_rat2 = rat1_rel_rat2(stg1, "<>", stg2)

End Function

Public Function find_lowerupper_bndry(lower As Boolean, stg As String, substg As String, pos As Integer)
Dim indx As Integer
Dim tmps As String


If Len(stg) <= 0 Then
find_lowerupper_bndry = 0
Exit Function
End If

If Len(stg) < pos And Not lower Then
find_lowerupper_bndry = pos
Exit Function
End If

tmps = stg

If Len(tmps) < Len(substg) Then
find_lowerupper_bndry = IIf(lower, 1, Len(stg))
Exit Function
End If

indx = IIf(lower, pos - Len(substg) + 1, pos)

While (lower And indx >= 1) Or (Not lower And indx <= (Len(tmps) - Len(substg) + 1))
    If Mid(tmps, indx, Len(substg)) = substg Then
        find_lowerupper_bndry = IIf(lower, indx + 1, indx - 1)
        Exit Function
    Else
        indx = IIf(lower, indx - 1, indx + 1)
    End If
Wend

find_lowerupper_bndry = IIf(lower, 1, Len(stg))

Exit Function
        
End Function

Public Function rat_valid_keypress(txt As String, pKey As Integer, keypos As Integer) As Boolean
Dim t As String
Dim t1 As String
Dim t2 As String

Dim lbnd As Integer
Dim ubnd As Integer
Dim i As Integer
Dim j As Integer
Dim k As Integer

t = Chr(pKey)

If Not (t = "+" Or t = "-" Or t = "/" Or t = "." Or (pKey >= 48 And pKey <= 57)) Then
    rat_valid_keypress = False
    Exit Function
End If

If Len(txt) <= 0 And t <> "/" Then
    rat_valid_keypress = True
    Exit Function
End If

If (Len(txt) <= 0 And t = "/") Or (right(txt, 1) = "/" And t = "/") Or (right(txt, 1) = "." And t = "/") Or (right(txt, 1) = "+" And t = "/") Or (right(txt, 1) = "-" And t = "/") Then
    rat_valid_keypress = False
    Exit Function
End If

If t = "." Then
    lbnd = find_lowerupper_bndry(True, txt, "/", IIf(keypos = -1 Or keypos = 0, Len(txt), keypos))
    ubnd = find_lowerupper_bndry(False, txt, "/", IIf(keypos = -1 Or keypos = 0, Len(txt), keypos))
    If lbnd <> 0 And ubnd <> 0 And lbnd <= ubnd Then
        i = search_string(Mid(txt, lbnd, ubnd - lbnd + 1), ".")
        If i <> -1 Then
            If keypos = -1 Or keypos = 0 Then
                rat_valid_keypress = False
                Exit Function
            Else
                t1 = Mid(txt, lbnd, ubnd - lbnd + 1)
                i = search_string(t1, ".")
                If i <> -1 Then
                    rat_valid_keypress = False
                    Exit Function
                End If
            End If
        End If
    End If
End If

If t = "+" Then
    lbnd = find_lowerupper_bndry(True, txt, "/", IIf(keypos = -1 Or keypos = 0, Len(txt), keypos))
    ubnd = find_lowerupper_bndry(False, txt, "/", IIf(keypos = -1 Or keypos = 0, Len(txt), keypos))
    If lbnd <> 0 And ubnd <> 0 And lbnd <= ubnd Then
        i = search_string(Mid(txt, lbnd, ubnd - lbnd + 1), "+")
        j = search_string(Mid(txt, lbnd, ubnd - lbnd + 1), "-")
        k = search_string(Mid(txt, lbnd, ubnd - lbnd + 1), ".")
        If i <> -1 Or j <> -1 Or k <> -1 Then
            If keypos = -1 Or keypos = 0 Then
                rat_valid_keypress = False
                Exit Function
            Else
                t1 = Mid(txt, lbnd, ubnd - lbnd + 1)
                i = search_string(t1, "+")
                j = search_string(t1, "-")
                k = search_string(t1, ".")
                If i <> -1 Or j <> -1 Or k <> -1 Then
                    rat_valid_keypress = False
                    Exit Function
                End If
            End If
        Else
            If Mid(txt, lbnd, ubnd - lbnd + 1) <> "" Then
                rat_valid_keypress = False
                Exit Function
            End If
        End If
    End If
End If

If t = "-" Then
    lbnd = find_lowerupper_bndry(True, txt, "/", IIf(keypos = -1 Or keypos = 0, Len(txt), keypos))
    ubnd = find_lowerupper_bndry(False, txt, "/", IIf(keypos = -1 Or keypos = 0, Len(txt), keypos))
    If lbnd <> 0 And ubnd <> 0 And lbnd <= ubnd Then
        i = search_string(Mid(txt, lbnd, ubnd - lbnd + 1), "-")
        j = search_string(Mid(txt, lbnd, ubnd - lbnd + 1), "+")
        k = search_string(Mid(txt, lbnd, ubnd - lbnd + 1), ".")
        If i <> -1 Or j <> -1 Or k <> -1 Then
            If keypos = -1 Or keypos = 0 Then
                rat_valid_keypress = False
                Exit Function
            Else
                t1 = Mid(txt, lbnd, ubnd - lbnd + 1)
                i = search_string(t1, "-")
                j = search_string(t1, "+")
                k = search_string(t1, ".")
                If i <> -1 Or j <> -1 Or k <> -1 Then
                    rat_valid_keypress = False
                    Exit Function
                End If
            End If
        Else
            If Mid(txt, lbnd, ubnd - lbnd + 1) <> "" Then
                rat_valid_keypress = False
                Exit Function
            End If
        End If
    End If
End If


rat_valid_keypress = True
    
End Function

Public Function rat_validtext(txt As String) As Boolean
Dim i As Integer

If Len(txt) = 0 Then
        rat_validtext = True
        Exit Function
End If
    
If left(txt, 1) = "/" Or right(txt, 1) = "/" Or right(txt, 1) = "+" Or right(txt, 1) = "-" Or right(txt, 1) = "." Then
    rat_validtext = False
    Exit Function
End If

If left(txt, 1) = "/" Then
        rat_validtext = False
        Exit Function
End If

For i = 1 To Len(txt) - 1 Step 1
    If Not rat_valid_keypress(Mid(txt, 1, i), Asc(Mid(txt, i + 1, 1)), i + 1) Then
        rat_validtext = False
        Exit Function
    End If
Next i
rat_validtext = True
End Function


Public Function rat_validsubtext(txt As String) As Boolean
Dim i As Integer

If Len(txt) = 0 Then
        rat_validsubtext = True
        Exit Function
End If
If left(txt, 1) = "/" Then
        rat_validsubtext = False
        Exit Function
End If
For i = 1 To Len(txt) - 1 Step 1
    If Not rat_valid_keypress(Mid(txt, 1, i), Asc(Mid(txt, i + 1, 1)), i + 1) Then
        rat_validsubtext = False
        Exit Function
    End If
Next i

rat_validsubtext = True
End Function

Public Function rat1_rel_rat2(r1 As String, rel As String, r2 As String) As Boolean
Dim rx As rat
Dim ry As rat
Dim left As Double
Dim right As Double

rx = string_rat(r1)
ry = string_rat(r2)

Call proper_sign(rx)
Call proper_sign(ry)

'left = rx.a * ry.b
'right = ry.a * rx.b

left = rx.a / rx.b
right = ry.a / ry.b

Select Case Trim(rel)

    Case "=":
                    rat1_rel_rat2 = IIf(left = right, True, False)
                    
    Case "<":
                    rat1_rel_rat2 = IIf(left < right, True, False)
                    
    Case ">":
                    rat1_rel_rat2 = IIf(left > right, True, False)
                    
    Case "<=":
                    rat1_rel_rat2 = IIf(left <= right, True, False)
                    
    Case ">=":
                    rat1_rel_rat2 = IIf(left >= right, True, False)
                    
    Case "<>":
                    rat1_rel_rat2 = IIf(left <> right, True, False)
                    
    Case Else:
            
                    MsgBox "RATIONAL-RELATIONAL ERROR!!!, RETURNING FALSE", vbOKOnly, "RATIONAL ERROR"
                    rat1_rel_rat2 = False
End Select
    
End Function





'-----------------------Epsilon------------------------------------'



Public Function find_epsilon(s As String) As epsilon
Dim indx As Integer
Dim x As epsilon

    indx = search_string(s, "E")
    If indx <> -1 Then
        If Trim(s) = "E" Then
            x.e = 1
            x.n = 0
        Else
            indx = search_string(s, "+")
            If indx = -1 Then indx = search_string(s, "-")
            If indx <> -1 Then
                x.e = Val(Mid(s, indx + 1, Len(s) - indx - 1))
                x.n = Val(Mid(s, 1, indx - 1))
            Else
                x.e = 0
                x.n = Val(s)
            End If
        End If
    Else
        x.e = 0
        x.n = Val(s)
    End If

find_epsilon = x
End Function

Public Function mul_epsilon(a As String, b As String) As String
Dim x As epsilon
Dim Y As epsilon

x = find_epsilon(a)
Y = find_epsilon(b)

mul_epsilon = Trim(str(x.n * Y.n)) & IIf(Round(x.e + Y.e, 8) <> 0, IIf(x.e + Y.e > 0, "+", "") & Trim(str(x.n * Y.e + x.e * Y.n + x.e * Y.e)) & "E", "")
End Function
Public Function add_epsilon(a As String, b As String) As String
Dim x As epsilon
Dim Y As epsilon

x = find_epsilon(a)
Y = find_epsilon(b)
add_epsilon = Trim(str(x.n + Y.n)) & IIf(Round(x.e + Y.e, 8) <> 0, IIf(x.e + Y.e > 0, "+", "") & Trim(str(x.e + Y.e)) & "E", "")
End Function

Public Function sub_epsilon(a As String, b As String) As String
Dim x As epsilon
Dim Y As epsilon

x = find_epsilon(a)
Y = find_epsilon(b)
sub_epsilon = Trim(str(x.n - Y.n)) & IIf(Round(x.e - Y.e, 8) <> 0, IIf(x.e - Y.e > 0, "+", "") & Trim(str(x.e - Y.e)) & "E", "")
End Function

Public Function ep1_les_ep2(a As String, b As String) As Boolean
Dim x As epsilon
Dim Y As epsilon

x = find_epsilon(a)
Y = find_epsilon(b)

If x.n < Y.n Then
    ep1_les_ep2 = True
Else
    If x.n > Y.n Then
        ep1_les_ep2 = False
    Else
        If x.e < x.e Then
            ep1_les_ep2 = True
        Else
            ep1_les_ep2 = False
        End If
    End If
End If

End Function


Public Sub dda_line(x1 As Double, y1 As Double, x2 As Double, y2 As Double, pic As PictureBox, clr As Long, isdelay As Boolean)
Dim x As Double
Dim Y As Double
Dim dx As Double
Dim dy As Double
Dim xinc As Double
Dim yinc As Double
Dim n As Double
Dim i As Double


dx = x2 - x1
dy = y2 - y1
n = IIf(Abs(dx) > Abs(dy), Abs(dx), Abs(dy))
xinc = dx / n
yinc = dy / n

x = x1
Y = y1
i = 1
While i <= n
    pic.PSet (x, Y), clr
    If isdelay Then Sleep (1)
    x = x + xinc
    Y = Y + yinc
    i = i + 1
Wend
    
End Sub


Public Sub error_me(i As Form)
Dim tmp As String

tmp = "Error found!!!" & vbCrLf & "UNLOADING, SORRY FOR THE INCONVINENCE.(" + i.Caption + ")." _
& vbCrLf & "DESCRIPTION OF ERROR FOLLOWS" & vbCrLf & vbCrLf & "ERROR:" & Err.Description & vbCrLf & "ERROR-NO:" & Err.Number & vbCrLf _
& "ERROR SOURCE:" & Err.Source & vbCrLf & "ERROR HELP FILE:" & Err.HelpFile & vbCrLf & "ERROR HELP CONTEXT:" & Err.HelpContext & vbCrLf & vbCrLf & "CAUTION:Abort Option will Terminate OpTech!!!" _
+ vbCrLf + "Retry/Ignore option will unload the form responsible for error."

If MsgBox(tmp, vbAbortRetryIgnore + vbMsgBoxHelpButton, "OpTech, Detected an unresolvable error!!!", Err.HelpFile, Err.HelpContext) = vbAbort Then
    Dim Form As Form
        For Each Form In Forms
            Unload Form
        Next Form
    SendKeys ("{ESC}")
    Exit Sub
End If
Err.clear
Unload i
SendKeys ("{ESC}")
End Sub

Public Function minorof(a() As rat, i As Long, j As Long, rows As Long, cols As Long, min() As rat, rn As Long, coln As Long) As Boolean
Dim l As Long
Dim m As Long
Dim p As Long
Dim q As Long

l = 0
m = 0

    If rows <= 1 Or cols <= 1 Or i < 0 Or j < 0 Or i >= rows Or j >= cols Then
        minorof = False
        Exit Function
    End If
        
    ReDim min(rows - 1, cols - 1) As rat
    For p = 0 To rows - 1 Step 1
        For q = 0 To cols - 1 Step 1
            If p <> i And q <> j Then
                min(l, m) = a(p, q)
                If m = cols - 2 Then
                    m = 0
                    l = l + 1
                Else
                    m = m + 1
                End If
            End If
        Next q
    Next p
    
    rn = rows - 1
    coln = cols - 1

    minorof = True

End Function

Public Function detof(a() As rat, rows As Long, cols As Long) As rat
Dim x() As rat
Dim det As rat
Dim rn As Long
Dim cn As Long
Dim j As Long

    det.a = 0
    det.b = 1
    If rows <= 0 Or cols <= 0 Then
        Exit Function
    End If
    If rows <= 1 And cols <= 1 Then
        detof = a(0, 0)
        Exit Function
    End If
    j = 0
    While j <= cols - 1
        Call minorof(a, 0, j, rows, cols, x, rn, cn)
        det = string_rat(ratadd(rat_stg(det), ratmul(ratmul(Trim(str((IIf(j Mod 2 = 0, 1, -1)))), rat_stg(a(0, j))), rat_stg(detof(x, rn, cn)))))
        j = j + 1
    Wend
    detof = det
End Function

Public Function adjof(a() As rat, rows As Long, cols As Long, adj() As rat, r As Long, c As Long) As Boolean
Dim coff() As rat
Dim min() As rat
Dim i As Long
Dim j As Long
Dim rn As Long
Dim cn As Long

    If rows <= 0 Or cols <= 0 Then
        adjof = False
        Exit Function
    End If

    ReDim coff(rows - 1, cols - 1) As rat
    ReDim adj(cols - 1, rows - 1) As rat
    For i = 0 To rows - 1 Step 1
        For j = 0 To cols - 1 Step 1
            If minorof(a, i, j, rows, cols, min, rn, cn) Then
                coff(i, j) = string_rat(ratmul(Trim(str(IIf((i + j) Mod 2 = 0, 1, -1))), rat_stg(detof(min, rn, cn))))
                adj(j, i) = coff(i, j)
            Else
                adj(j, i).a = 1
                adj(j, i).b = 1
            End If
        Next j
    Next i
    r = cols
    c = rows

adjof = True
End Function

Public Function invof(a() As rat, rows As Long, cols As Long, inv() As rat, r As Long, c As Long) As Boolean
Dim i As Long
Dim j As Long
Dim m As rat
Dim adj() As rat
m = detof(a, rows, cols)

    If m.a = 0 Then
        invof = False
        Exit Function
    End If
    Call adjof(a, rows, cols, adj, r, c)
    ReDim inv(r - 1, c - 1) As rat
    For i = 0 To r - 1 Step 1
        For j = 0 To c - 1 Step 1
            inv(i, j) = string_rat(ratdiv(rat_stg(adj(i, j)), rat_stg(m)))
        Next j
    Next i

invof = True
End Function



Public Function matmul(m1() As rat, m As Long, n As Long, m2() As rat, o As Long, p As Long, m3() As rat, q As Long, r As Long) As Boolean
Dim i As Long
Dim k As Long
Dim j As Long

  If n <> o Or m <= 0 Or n <= 0 Or o <= 0 Or p <= 0 Then
    matmul = False
    Exit Function
  End If

  ReDim m3(m - 1, p - 1) As rat
  For i = 0 To m - 1 Step 1
    For j = 0 To p - 1 Step 1
        m3(i, j).a = 0
        m3(i, j).b = 0
        For k = 0 To n - 1 Step 1
            m3(i, j) = string_rat(ratadd(rat_stg(m3(i, j)), ratmul(rat_stg(m1(i, k)), rat_stg(m2(k, j)))))
        Next k
    Next j
  Next i

  q = m
  r = p

matmul = True
End Function

Public Function chngerows(x() As rat, r1 As Long, r2 As Long, rows As Long, cols As Long) As Boolean
Dim j As Long
Dim t As rat
    
    If rows <= 0 Or cols <= 0 Or r1 < 0 Or r2 < 0 Or r1 >= rows Or r2 >= rows Then
        chngerows = False
        Exit Function
    End If

    For j = 0 To cols - 1 Step 1
        t = x(r1, j)
        x(r1, j) = x(r2, j)
        x(r2, j) = t
    Next j
    chngerows = True

End Function

Public Function chngecols(x() As rat, c1 As Long, c2 As Long, rows As Long, cols As Long) As Boolean
Dim i As Long
Dim j As Long
Dim t As rat
    
    If rows <= 0 Or cols <= 0 Or c1 < 0 Or c2 < 0 Or c1 >= cols Or c2 >= cols Then
        chngecols = False
        Exit Function
    End If
    
    For i = 0 To rows - 1 Step 1
        t = x(i, c1)
        x(i, c1) = x(i, c2)
        x(i, c2) = t
    Next i

 chngecols = True

End Function

Public Function transposeof(x() As rat, r As Long, c As Long, Y() As rat, rowt As Long, colt As Long) As Boolean
Dim i As Long
Dim j As Long
    
    If r <= 0 Or c <= 0 Then
        transposeof = False
        Exit Function
    End If
    rowt = c
    colt = r
    ReDim Y(rowt, colt) As rat
    For i = 0 To r - 1 Step 1
        For j = 0 To c - 1 Step 1
           Y(j, i) = x(i, j)
        Next j
    Next i
    transposeof = True
End Function
Public Function cpymatx(x() As rat, r As Long, c As Long, Y() As rat) As Boolean
Dim i As Long
Dim j As Long

    If r <= 0 Or c <= 0 Then
        cpymatx = False
        Exit Function
    End If
    ReDim Y(r - 1, c - 1) As rat
    For i = 0 To r - 1 Step 1
        For j = 0 To c - 1 Step 1
            Y(i, j).a = x(i, j).a
            Y(i, j).b = x(i, j).b
        Next j
    Next i

cpymatx = True
End Function

Public Function rank_pivot_tounity(x() As rat, rows As Long, cols As Long) As Boolean
Dim a() As rat
Dim min() As rat
Dim k As rat
Dim i As Long
Dim j As Long
Dim rn As Long
Dim cn As Long
    
    rank_pivot_tounity = False
    Call cpymatx(x, rows, cols, a)
    k = a(0, 0)
    For j = 0 To cols - 1 Step 1
        a(0, j) = string_rat(ratdiv(rat_stg(a(0, j)), rat_stg(k)))
    Next j

    For j = 1 To cols - 1 Step 1
        k = a(0, j)
        For i = 0 To rows - 1 Step 1
            a(i, j) = string_rat(ratsub(rat_stg(a(i, j)), ratmul(rat_stg(k), rat_stg(a(i, 0)))))
        Next i
    Next j
    
    For i = 1 To rows - 1 Step 1
        k = a(i, 0)
        For j = 0 To cols - 1 Step 1
            a(i, j) = string_rat(ratsub(rat_stg(a(i, j)), ratmul(rat_stg(k), rat_stg(a(0, j)))))
        Next j
    Next i
    
    x = a
     rank_pivot_tounity = True
End Function

Public Function rank_pivot_tounity_sub(x() As rat, rows As Long, cols As Long) As Boolean
Dim a() As rat
Dim min() As rat
Dim k As rat
Dim rn As Long
Dim cn As Long

    rank_pivot_tounity_sub = False
    Call cpymatx(x, rows, cols, a)
    If minorof(a, 0, 0, rows, cols, min, rn, cn) Then
        rank_pivot_tounity_sub = True
        Call cpymatx(min, rn, cn, x)
        rows = rn
        cols = cn
    End If
    
End Function

Public Function rank_pivot(x() As rat, rows As Long, cols As Long, piv As rat) As Boolean
Dim a() As rat
Dim i As Long
Dim j As Long
Dim flg As Boolean

    rank_pivot = False
    piv.a = -1
    piv.b = -1
    If rows <= 0 Or cols <= 0 Then Exit Function

    Call cpymatx(x, rows, cols, a)
    flg = False
    For i = 0 To rows - 1 Step 1
        If flg = True Then Exit For
        For j = 0 To cols - 1 Step 1
            If rat_gret0(rat_abs(rat_stg(a(i, j)))) Then
                piv.a = i
                piv.b = j
                flg = True
                Exit For
            End If
        Next j
    Next i
    If flg Then rank_pivot = True
    
End Function

Public Function rankof(x() As rat, rows As Long, cols As Long) As Long
Dim min() As rat
Dim a() As rat
Dim k As rat
Dim i As Long
Dim j As Long
Dim rn As Long
Dim cn As Long
Dim flg As Boolean

    rankof = 0
    If rows <= 0 Or cols <= 0 Then Exit Function

    Call cpymatx(x, rows, cols, a)
    flg = False
    For i = 0 To rows - 1 Step 1
        If flg = True Then Exit For
        For j = 0 To cols - 1 Step 1
            If rat_gret0(rat_abs(rat_stg(a(i, j)))) Then
                rn = i
                cn = j
                flg = True
                Exit For
            End If
        Next j
    Next i
    
    rankof = 0
    If flg = False Then Exit Function

    Call chngerows(a, 0, rn, rows, cols)
    Call chngecols(a, 0, cn, rows, cols)

    k = a(0, 0)
    For j = 0 To cols - 1 Step 1
        a(0, j) = string_rat(ratdiv(rat_stg(a(0, j)), rat_stg(k)))
    Next j

    For j = 1 To cols - 1 Step 1
        k = a(0, j)
        For i = 0 To rows - 1 Step 1
            a(i, j) = string_rat(ratsub(rat_stg(a(i, j)), ratmul(rat_stg(k), rat_stg(a(i, 0)))))
        Next i
    Next j
    
    For i = 1 To rows - 1 Step 1
        k = a(i, 0)
        For j = 0 To cols - 1 Step 1
            a(i, j) = string_rat(ratsub(rat_stg(a(i, j)), ratmul(rat_stg(k), rat_stg(a(0, j)))))
        Next j
    Next i
    Call minorof(a, 0, 0, rows, cols, min, rn, cn)
    
    rankof = 1 + rankof(min, rn, cn)
End Function

Public Function row_rank_pivot(i As Long, x As matrix, piv As rat) As Boolean
Dim j As Long
Dim flg As Boolean
Dim k As Long
    
  row_rank_pivot = False
  If x.rows <= 0 Or x.cols <= 0 Then Exit Function
        
        flg = False
        For k = i To x.rows - 1 Step 1
            If flg Then Exit For
            flg = False
            For j = 0 To x.cols - 1 Step 1
                If rat_gret0(rat_abs(rat_stg(x.matx(k, j)))) Then
                   flg = True
                   piv.a = k
                   piv.b = j
                   Exit For
                End If
           Next j
        Next k
        
        If flg = False Then
             Exit Function
        Else
            row_rank_pivot = True
             x.rank = x.rank + 1
        End If

End Function

Public Function row_rank_pivot_tounity(i As Long, x() As rat, rows As Long, cols As Long, piv As rat) As Boolean
Dim m As rat
Dim k As Long
Dim j As Long
        
        row_rank_pivot_tounity = False
        m = x(i, piv.b)
        For j = 0 To cols - 1 Step 1
            x(i, j) = string_rat(ratdiv(rat_stg(x(i, j)), rat_stg(m)))
        Next j

        For k = 0 To rows - 1 Step 1
            m = x(k, piv.b)
            For j = 0 To cols - 1 Step 1
                If k = i Then
                    Exit For
                Else
                    x(k, j) = string_rat(ratsub(rat_stg(x(k, j)), ratmul(rat_stg(m), rat_stg(x(i, j)))))
                End If
            Next j
        Next k
        i = i + 1
        row_rank_pivot_tounity = True
End Function

Public Sub rowcanon_finalize(x As matrix)
Dim rowc As Long
Dim colc As Long
Dim i As Long
Dim k As Long
    
    rowc = x.rank
    colc = x.cols

    For i = 0 To rowc - 1 Step 1
        If rat_eq0(rat_stg(x.matx(i, i))) Then
        For k = i + 1 To rowc - 1 Step 1
            If rat_neq0(rat_stg(x.matx(k, i))) Then
                Call chngerows(x.matx, i, k, rowc, colc)
                Exit For
            End If
        Next k
        End If
    Next i

End Sub

Public Function rowcanonicalmatxof(Y() As rat, rows As Long, cols As Long, x() As rat, rowc As Long, colc As Long) As Long
Dim i As Long
Dim j As Long
Dim k As Long
Dim l As Long
Dim r1 As Long
Dim c1 As Long
Dim flg As Boolean
Dim m As rat
    
    rowcanonicalmatxof = 0
    If rows <= 0 Or cols <= 0 Then Exit Function
    Call cpymatx(Y, rows, cols, x)
    l = 0
    For i = 0 To rows - 1 Step 1
        flg = False
        For k = i To rows - 1 Step 1
            If flg Then Exit For
            flg = False
            For j = 0 To cols - 1 Step 1
                If rat_gret0(rat_abs(rat_stg(x(k, j)))) Then
                   flg = True
                   r1 = k
                   c1 = j
                   Exit For
                End If
           Next j
        Next k
        If flg = False Then
              Exit For
        Else
              l = l + 1
        End If
        Call chngerows(x, i, r1, rows, cols)
        m = x(i, c1)
        For j = 0 To cols - 1 Step 1
            x(i, j) = string_rat(ratdiv(rat_stg(x(i, j)), rat_stg(m)))
        Next j

        For k = 0 To rows - 1 Step 1
            m = x(k, c1)
            For j = 0 To cols - 1 Step 1
                If k = i Then
                    Exit For
                Else
                    x(k, j) = string_rat(ratsub(rat_stg(x(k, j)), ratmul(rat_stg(m), rat_stg(x(i, j)))))
                End If
            Next j
        Next k
    Next i
            
    

     rowc = l
     colc = cols

    For i = 0 To rowc - 1 Step 1
        If rat_eq0(rat_stg(x(i, i))) Then
        For k = i + 1 To rowc - 1 Step 1
            If rat_neq0(rat_stg(x(k, i))) Then
                Call chngerows(x, i, k, rowc, colc)
                Exit For
            End If
        Next k
        End If
    Next i

rowcanonicalmatxof = l
End Function

Public Sub create_matrix(id_ As Long, m As matrix)
Dim Y As New Recordset
    Call connect
    m.id_ = id_
    Set Y = dn.cn.Execute("select rs,cs from matx_main where matxid=" & id_ & "")
    Y.MoveFirst
    m.rows = Y.Fields("rs")
    m.cols = Y.Fields("cs")
    ReDim m.matx(m.rows - 1, m.cols - 1) As rat
    m.id_ = id_
    Set Y = dn.cn.Execute("select r,c,elmnt from matx_sub1 where matxid=" & id_ & "")
    Y.MoveFirst
    While Not Y.EOF
        m.matx(Y.Fields("r") - 1, Y.Fields("c") - 1) = string_rat(real_rat(Y.Fields("elmnt")))
        Y.MoveNext
    Wend
End Sub

Public Sub create_linear_eqns(id_ As Long, mat As matrix, constant As matrix)
Dim Y As New Recordset
Dim m As matrix
Dim i As Long
Dim j As Long
    Call connect
    
    m.id_ = id_
    Set Y = dn.cn.Execute("select rs,cs from matx_main where matxid=" & id_ & "")
    Y.MoveFirst
    m.rows = Y.Fields("rs")
    m.cols = Y.Fields("cs")
    ReDim m.matx(m.rows - 1, m.cols - 1) As rat
    Set Y = dn.cn.Execute("select r,c,elmnt from matx_sub1 where matxid=" & id_ & "")
    Y.MoveFirst
    While Not Y.EOF
        m.matx(Y.Fields("r") - 1, Y.Fields("c") - 1) = string_rat(real_rat(Y.Fields("elmnt")))
        Y.MoveNext
    Wend
    mat.rows = m.rows
    mat.cols = m.cols - 1
    constant.rows = m.rows
    constant.cols = 1
    mat.id_ = m.id_
    constant.id_ = m.id_
    ReDim mat.matx(mat.rows - 1, mat.cols - 1) As rat
    ReDim constant.matx(constant.rows - 1, constant.cols - 1) As rat
    For i = 0 To m.rows - 1 Step 1
        For j = 0 To m.cols - 2 Step 1
            mat.matx(i, j) = m.matx(i, j)
        Next j
        constant.matx(i, 0) = m.matx(i, j)
    Next i
End Sub

Public Sub replace_column(mat As matrix, col As Long, cnst As matrix)
Dim i As Long
For i = 0 To mat.rows - 1 Step 1
    mat.matx(i, col) = cnst.matx(i, 0)
Next i
End Sub
Public Sub display_matrix(rtf As RichTextBox, m As matrix, lft As Long, ishead As Boolean, idflg As Boolean, Optional pbar As ProgressBar)
Dim tmp As String
Dim t1 As String
Dim i As Long
Dim j As Long

With rtf
    .Text = .Text + "  " + vbCrLf & vbCrLf
    If ishead Then
        If Not idflg Then
            tmp = Space(lft) + "MATRIX ID:" + Trim(str(m.id_)) + vbCrLf + Space(lft) + give_sepchar(".", Len("MATRIX ID:" + Trim(str(m.id_))))
            .Text = .Text + tmp + vbCrLf
        End If
        tmp = "Number of rows:" + Trim(str(m.rows)) + ",Number of columns:" + Trim(str(m.cols)) + "."
        .Text = .Text & Space(5) & space_half(35, tmp) & tmp & vbCrLf
        .Text = .Text & Space(5) & space_half(35, tmp) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
    End If
    t1 = "      ROW/COL:"
    For i = 1 To m.cols Step 1
        t1 = t1 & spaces(14, "C" + Trim(str(i))) & Mid(Trim("C" + Trim(str(i))), 1, 14) + " "
    Next i
    .Text = .Text & Space(lft) & t1 & vbCrLf
    i = 0
    If Not pbar Is Nothing Then
        pbar.Value = 0
        pbar.max = m.rows * m.cols
        pbar.Visible = True
    End If
    While i < m.rows
        j = 0
        t1 = spaces(14, "R" + Trim(str(i + 1))) & Mid(Trim("R" + Trim(str(i + 1))), 1, 14)
        While j < m.cols
            tmp = Trim(rat_stg(m.matx(i, j)))
            t1 = t1 & spaces(14, tmp) & Mid(tmp, 1, 14) + " "
            j = j + 1
            If Not pbar Is Nothing Then pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
        Wend
        t1 = t1 & vbCrLf
        .Text = .Text + Space(lft) + t1
        i = i + 1
    Wend
    If Not pbar Is Nothing Then
        pbar.Value = pbar.max
        pbar.Visible = False
    End If
End With
End Sub

Public Sub map_matrix_grid(mx As matrix, gd As MSHFlexGrid)
Dim i As Long
Dim j As Long
    
    gd.clear
    gd.rows = mx.rows + 1
    gd.cols = mx.cols + 1
    If gd.rows <= 1 Or gd.cols <= 1 Then
        Exit Sub
    End If
    gd.FixedCols = 1
    gd.FixedRows = 1
    For i = 1 To gd.cols - 1 Step 1
        gd.row = 0
        gd.col = i
        gd.CellAlignment = 3
        gd.TextMatrix(0, i) = "Col" + Trim(str(i))
    Next i
    For i = 1 To gd.rows - 1 Step 1
        gd.row = i
        gd.col = 0
        gd.CellAlignment = 3
        gd.TextMatrix(i, 0) = "Row" + Trim(str(i))
    Next i
    For i = 1 To gd.rows - 1 Step 1
        For j = 1 To gd.cols - 1 Step 1
            gd.row = i
            gd.col = j
            gd.CellAlignment = 3
            gd.TextMatrix(i, j) = rat_stg(mx.matx(i - 1, j - 1))
         Next j
    Next i
    For i = 0 To gd.cols - 1 Step 1
        gd.ColWidth(i) = 2500
    Next i
End Sub

Public Function isunitmatrix(mx As matrix) As Boolean
Dim i As Long
Dim j As Long

isunitmatrix = False
If mx.rows <= 0 Or mx.cols <= 0 Or mx.rows <> mx.cols Then
    Exit Function
End If
For i = 0 To mx.rows - 1 Step 1
    For j = 0 To mx.cols - 1 Step 1
        If (i <> j And rat_neq0(rat_stg(mx.matx(i, j)))) Or (i = j And rat1_neq_rat2(rat_stg(mx.matx(i, j)), "1")) Then
            Exit Function
        End If
    Next j
Next i
isunitmatrix = True
End Function

Public Function isequalmatrices(m1 As matrix, m2 As matrix) As Boolean
Dim i As Long
Dim j As Long
    
    isequalmatrices = False
    If m1.rows <= 0 Or m1.cols <= 0 Or m1.rows <> m2.rows Or m1.cols <> m2.cols Then
        Exit Function
    End If
    For i = 0 To m1.rows - 1 Step 1
        For j = 0 To m2.cols - 1 Step 1
            If rat1_neq_rat2(rat_stg(m1.matx(i, j)), rat_stg(m2.matx(i, j))) Then
                Exit Function
            End If
        Next j
    Next i
    isequalmatrices = True
End Function

Public Function matrixequaltoconst(m1 As matrix, constant As String) As Boolean
Dim i As Long
Dim j As Long
    
    matrixequaltoconst = False
    If m1.rows <= 0 Or m1.cols <= 0 Then
        Exit Function
    End If
    For i = 0 To m1.rows - 1 Step 1
        For j = 0 To m1.cols - 1 Step 1
            If rat1_neq_rat2(rat_stg(m1.matx(i, j)), constant) Then
                Exit Function
            End If
        Next j
    Next i
    matrixequaltoconst = True
End Function

Public Function const_matmul(m1 As matrix, constant As String, m2 As matrix) As Boolean
Dim i As Long
Dim j As Long
    
    const_matmul = False
    If m1.rows <= 0 Or m1.cols <= 0 Then
        Exit Function
    End If
    m2.rows = m1.rows
    m2.cols = m1.cols
    ReDim m2.matx(m2.rows, m2.cols) As rat
    For i = 0 To m1.rows - 1 Step 1
        For j = 0 To m1.cols - 1 Step 1
            m2.matx(i, j) = string_rat(ratmul(rat_stg(m1.matx(i, j)), constant))
        Next j
    Next i
    const_matmul = True
End Function

Public Sub display_linear_eqns(rtf As RichTextBox, m As matrix, lft As Long, ishead As Boolean, idflg As Boolean, Optional pbar As ProgressBar)
Dim tmp As String
Dim t1 As String
Dim i As Long
Dim j As Long

With rtf
    .Text = .Text + "  " + vbCrLf & vbCrLf
    If ishead Then
        If Not idflg Then
            tmp = Space(lft) + "LINEAR EQUATIONS PROBLEM ID:" + Trim(str(m.id_)) + vbCrLf + Space(lft) + give_sepchar(".", Len("LINEAR EQUATIONS PROBLEM ID:" + Trim(str(m.id_))))
            .Text = .Text + tmp + vbCrLf
        End If
        tmp = "Number of Equations:" + Trim(str(m.rows)) + ",Number of Unknowns:" + Trim(str(m.cols - 1)) + "."
        .Text = .Text & vbCrLf & Space(5) & space_half(35, tmp) & tmp & vbCrLf
        .Text = .Text & Space(5) & space_half(35, tmp) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
    End If
    i = 0
    If Not pbar Is Nothing Then
        pbar.Value = 0
        pbar.Visible = True
        pbar.max = m.rows * (m.cols - 1)
    End If
    While i < m.rows
        j = 0
        t1 = ""
        While j < m.cols - 1
            tmp = Trim(rat_stg(m.matx(i, j)))
            t1 = t1 & IIf(j = 0 And rat_geq0(tmp), " ", IIf(rat_less0(tmp), "", "+")) + tmp + "X" + Trim(str(j + 1)) + IIf(j = m.cols - 2, "=", "")
            If Not pbar Is Nothing Then pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
            j = j + 1
        Wend
        t1 = t1 & rat_stg(m.matx(i, j)) & "."
        t1 = t1 & vbCrLf
        .Text = .Text + Space(lft) + t1
        i = i + 1
    Wend
    If Not pbar Is Nothing Then
        pbar.Value = pbar.max
        pbar.Visible = False
    End If
End With
End Sub



Public Function is_valid_text(txt As TextBox, backuptxt As String, minus As Boolean, dot As Boolean) As Boolean
Dim tmp As String
    If is_valid_textsub(txt, backuptxt, minus, dot) Then
        tmp = right(txt, 1)
        If tmp = "." Or tmp = "-" Or tmp = "+" Then
            txt = backuptxt
            is_valid_text = False
        Else
            backuptxt = txt
            is_valid_text = True
        End If
    Else
        txt = backuptxt
        is_valid_text = False
    End If
End Function

Public Function is_valid_textsub(txt As TextBox, backuptxt As String, minus As Boolean, dot As Boolean) As Boolean
Dim i As Long
Dim tmp As String
Dim dotflg As Boolean

        
    dotflg = False
    For i = 1 To Len(txt) Step 1
        tmp = Mid(txt, i, 1)
        
        If Not (isnumeric(tmp) Or (dot And tmp = ".") Or (minus And (tmp = "-" Or tmp = "+"))) Then
                is_valid_textsub = False
                txt = backuptxt
                SendKeys "{END}", True
                Exit Function
        End If
        
        If (tmp = "-" Or tmp = "+") And i <> 1 Then
                is_valid_textsub = False
                txt = backuptxt
                SendKeys "{END}", True
                Exit Function
        Else
            If tmp = "." Then
                If dotflg Then
                    is_valid_textsub = False
                    txt = backuptxt
                    SendKeys "{END}", True
                    Exit Function
                Else
                    dotflg = True
                End If
            End If
        End If
    Next i
    
backuptxt = txt
is_valid_textsub = True
End Function
