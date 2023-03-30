Attribute VB_Name = "OTM1"

Option Explicit


'----------------GLOBAL CONNECTION--------------'

                Type DBASE
                    
                    cn As New ADODB.Connection
                    
                End Type
                
                Public db_type_oracle As Boolean
                
                Public dn As DBASE


Type std_lpp
    ismax As Boolean
    n As Long
    m As Long
    obj() As Double
    lpp() As Double
    rel() As Integer
    is_unrestricted() As Boolean
    unrestricted() As Long
End Type


Type pivot
    xist As Boolean
    row As Integer
    col As Integer
End Type

Type lpp_ints
    vars As Integer
    isint() As Boolean
End Type

Type subprblm
    id As Long
    state As Integer
    subcnt As String
End Type

Type subdetails
    x() As String
End Type

Public lpp_varint As lpp_ints

Type real_line
    m As Double
    c As Double
    xincpt As Boolean
    iserror As Boolean
 End Type


Type lpp_line
    x1 As Double
    x2 As Double
    eq_type As Integer
    const As Double
    aline As real_line
End Type

Type end_points
    x0 As point
    y0 As point
    x0_valid As Boolean
    y0_valid As Boolean
End Type

Type lpp_lines
    endpoints() As end_points
    lines() As lpp_line
    cnt As Long
    common_region As Boolean
    inner_region As Boolean
    ismax As Boolean
    obj_x1 As Double
    obj_x2 As Double
End Type


Type corner_points
    cnt As Long
    corners() As point
    inpoint As point
End Type


Public Sub draw_lpp_graph(xyp As xy_plane, lline As lpp_lines, cor As corner_points, intsec As corner_points, rintsec As corner_points, bndry As end_points, pic As PictureBox, aflg As Boolean)
Dim tmp As String
Dim rl As real_line
Dim ep As end_points
Dim p1 As point
Dim p2 As point
Dim i As Long
Dim res As Double
Dim restmp As Double
Dim indx As Long
Dim dup As Boolean
Dim l As Long
Dim m As Long
Dim n As Long
Dim tmpl As Integer
    
       
    pic.FontBold = True
    pic.FontItalic = False
    pic.FontBold = True
    pic.FontSize = 8
    pic.FontName = "courier new"
    pic.ForeColor = RGB(0, 0, 0)
    pic.DrawMode = 9
    pic.DrawStyle = 0
    
xyp.x_centre = 1 * 8 + 2 * 8 + Len(Trim(str(Round(xyp.y_max, 4)))) * 6
xyp.x_axis_len = pic.ScaleWidth - xyp.x_centre - (2 * 8)
xyp.y_centre = 6 * 3 + 1 * 8
xyp.y_axis_len = pic.ScaleHeight - 16 * lline.cnt - xyp.y_centre
xyp.xinc = xyp.x_max / 10
xyp.yinc = xyp.y_max / 10
Call map_xycentreto_object(xyp, pic)

p1.x = 0
p1.Y = xyp.y_max
tmp = "OBJECTIVE FUNCTION : " & IIf(lline.ismax, "MAX(Z)=", "MIN(Z)=") & Trim(str(lline.obj_x1)) & "X1" & IIf(lline.obj_x2 >= 0, "+", "") & Trim(str(lline.obj_x2)) & "X2."
l = Len(tmp)
p2 = map_pointto_xyplane(p1, xyp)
p2.Y = p2.Y - (lline.cnt - 0.5) * 16
pic.CurrentX = p2.x
pic.CurrentY = p2.Y
pic.Print tmp
p2.Y = p2.Y + 16
tmp = "CONSTRAINTS:"
pic.CurrentX = p2.x
pic.CurrentY = p2.Y
pic.Print tmp
p2.x = p2.x + 24
i = 0
While i <= lline.cnt - 4
    p2.Y = p2.Y + 16
    tmp = "L" & Trim(str(i + 1)) & " : " & Trim(str(lline.lines(i).x1)) & "X1" & IIf(lline.lines(i).x2 >= 0, "+", "") & Trim(str(lline.lines(i).x2)) & "X2" & IIf(lline.lines(i).eq_type = 0, "=", IIf(lline.lines(i).eq_type > 0, ">=", "<=")) & Trim(str(lline.lines(i).const)) & IIf(i = lline.cnt - 4, " , X1,X2>=0.", "")
    l = IIf(Len(tmp) > l, Len(tmp), l)
    pic.CurrentX = p2.x
    pic.CurrentY = p2.Y
    pic.Print tmp
    i = i + 1
Wend
    
    pic.FontBold = True
    pic.FontItalic = False
    pic.FontSize = 7
    pic.FontName = "courier new"
    pic.ForeColor = RGB(0, 0, 0)
    
p1.x = 0
p1.Y = 0
While p1.Y <= xyp.y_max
        p2 = map_pointto_xyplane(p1, xyp)
        pic.Line (p2.x, p2.Y)-(p2.x - 8, p2.Y), RGB(200, 0, 0)
        tmp = Trim(str(Round(p1.Y, 4)))
        p2.x = p2.x - 8 - 6 * Len(tmp)
        p2.Y = p2.Y - 5
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print tmp
        p1.Y = p1.Y + xyp.yinc
Wend

p1.x = xyp.xinc
p1.Y = 0
While p1.x <= xyp.x_max
        p2 = map_pointto_xyplane(p1, xyp)
        pic.Line (p2.x, p2.Y)-(p2.x, p2.Y + 8), RGB(200, 0, 0)
        tmp = Trim(str(Round(p1.x, 4)))
        p2.x = p2.x - (Len(tmp) * 6) / 2#
        p2.Y = p2.Y + 8
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print tmp
        p1.x = p1.x + xyp.xinc
Wend
    
l = 150
m = 25
n = 75
i = lline.cnt - 2
While i >= 0
    tmpl = n
    n = m
    m = l
    l = tmpl
    If lline.endpoints(i).x0_valid And lline.endpoints(i).y0_valid Then
        p1 = lline.endpoints(i).x0
        p2 = lline.endpoints(i).y0
        p1 = map_pointto_xyplane(p1, xyp)
        p2 = map_pointto_xyplane(p2, xyp)
        If Not aflg Or i = lline.cnt - 2 Or i = lline.cnt - 3 Then
            pic.Line (p1.x, p1.Y)-(p2.x, p2.Y), IIf(i <= lline.cnt - 4, RGB(l, m, n), RGB(250, 0, 0))
        Else
            Call dda_line(p1.x, p1.Y, p2.x, p2.Y, pic, IIf(i <= lline.cnt - 4, RGB(l, m, n), RGB(250, 0, 0)), True)
        End If
        pic.Line (p1.x, p1.Y)-(p2.x, p2.Y), IIf(i <= lline.cnt - 4, RGB(l, m, n), RGB(250, 0, 0))
        pic.Line (p1.x, p1.Y)-(p2.x, p2.Y), IIf(i <= lline.cnt - 4, RGB(l, m, n), RGB(250, 0, 0))
        If lline.cnt - 4 >= i Then
            pic.CurrentX = (p1.x + p2.x) / 2#
            pic.CurrentY = (p1.Y + p2.Y) / 2#
            pic.Print "L" & Trim(str(i + 1))
        End If
    End If
    i = i - 1
Wend
    
    pic.FontBold = True
    pic.FontItalic = False
    pic.FontBold = True
    pic.FontSize = 8
    pic.FontName = "courier new"
    pic.ForeColor = RGB(0, 0, 0)
        
If lline.common_region Then
   Call fill_bndry(xyp, lline, cor, rintsec, bndry, pic)
End If

If lline.inner_region Then
   For i = 0 To intsec.cnt Step 1
        restmp = lline.obj_x1 * intsec.corners(i).x + lline.obj_x2 * intsec.corners(i).Y
        If i = 0 Then
            indx = 0
            res = restmp
            dup = False
        Else
            If restmp = res Then
                dup = True
            Else
                indx = IIf(lline.ismax, IIf(res < restmp, i, indx), IIf(res > restmp, i, indx))
                res = IIf(lline.ismax, IIf(res < restmp, restmp, res), IIf(res > restmp, restmp, res))
            End If
        End If
    Next i
    rl = linefrom_eqn(lline.obj_x1, lline.obj_x2, Round(res, 6))
    If Not rl.iserror Then
        If rl.xincpt Then
            ep.y0.Y = 0
            ep.y0.x = rl.c
            If ep.y0.x < 0 Or ep.y0.x > xyp.x_max Then
                ep.y0_valid = False
            Else
                ep.y0_valid = True
            End If
            
            If rl.m <> 0 Then
                ep.x0.x = 0
                ep.x0.Y = -rl.c / rl.m
                If ep.x0.Y < 0 Or ep.x0.Y > xyp.y_max Then
                    ep.x0_valid = False
                Else
                    ep.x0_valid = True
                End If
            Else
                ep.x0_valid = False
            End If
        Else
            ep.x0.x = 0
            ep.x0.Y = rl.c
            If ep.x0.Y < 0 Or ep.x0.Y > xyp.y_max Then
                ep.x0_valid = False
            Else
                ep.x0_valid = True
            End If
            
            If rl.m <> 0 Then
                ep.y0.Y = 0
                ep.y0.x = -rl.c / rl.m
                If ep.y0.x < 0 Or ep.y0.x > xyp.x_max Then
                    ep.y0_valid = False
                Else
                    ep.y0_valid = True
                End If
            Else
                ep.y0_valid = False
            End If
        End If
        
    If Not rl.xincpt Then
        If Not ep.x0_valid Then
           ep.x0.x = xyp.x_max
           ep.x0.Y = rl.m * xyp.x_max + rl.c
            If ep.x0.Y < 0 Or ep.x0.Y > xyp.y_max Then
                If rl.m <> 0 Then
                   ep.x0.Y = xyp.y_max
                   ep.x0.x = (xyp.y_max - rl.c) / rl.m
                   ep.x0_valid = True
                Else
                   ep.x0_valid = False
                End If
            Else
                ep.x0_valid = True
            End If
        End If
        
        If Not ep.y0_valid Then
           ep.y0.x = xyp.x_max
           ep.y0.Y = rl.m * xyp.x_max + rl.c
            If ep.y0.Y < 0 Or ep.y0.Y > xyp.y_max Then
                If rl.m <> 0 Then
                   ep.y0.Y = xyp.y_max
                   ep.y0.x = (xyp.y_max - rl.c) / rl.m
                   ep.y0_valid = True
                Else
                   ep.y0_valid = False
                End If
            Else
                ep.y0_valid = True
            End If
        End If
    Else
        If Not ep.y0_valid Then
           ep.y0.Y = xyp.y_max
           ep.y0.x = rl.m * xyp.y_max + rl.c
            If ep.y0.x < 0 Or ep.y0.x > xyp.x_max Then
                If rl.m <> 0 Then
                   ep.y0.x = xyp.x_max
                   ep.y0.Y = (xyp.x_max - rl.c) / rl.m
                   ep.y0_valid = True
                Else
                   ep.y0_valid = False
                End If
            Else
                ep.y0_valid = True
            End If
        End If
        
        If Not ep.x0_valid Then
           ep.x0.Y = xyp.y_max
           ep.x0.x = rl.m * xyp.y_max + rl.c
            If ep.x0.x < 0 Or ep.x0.x > xyp.x_max Then
                If rl.m <> 0 Then
                   ep.x0.x = xyp.x_max
                   ep.x0.Y = (xyp.x_max - rl.c) / rl.m
                   ep.x0_valid = True
                Else
                   ep.x0_valid = False
                End If
            Else
                ep.x0_valid = True
            End If
        End If
    
    End If
    
    If ep.x0_valid And ep.y0_valid Then
        p1 = ep.x0
        p2 = ep.y0
        p1 = map_pointto_xyplane(p1, xyp)
        p2 = map_pointto_xyplane(p2, xyp)
          pic.DrawMode = 9
          pic.DrawStyle = 1
        If Not aflg Then
            pic.Line (p1.x, p1.Y)-(p2.x, p2.Y), RGB(0, 0, 300)
        Else
            Call dda_line(p1.x, p1.Y, p2.x, p2.Y, pic, RGB(0, 0, 300), True)
            Call dda_line(p1.x, p1.Y, p2.x, p2.Y, pic, pic.BackColor, False)
        End If
        pic.Line (p1.x, p1.Y)-(p2.x, p2.Y), RGB(0, 0, 300)
            pic.CurrentX = (p1.x + p2.x) / 2#
            pic.CurrentY = (p1.Y + p2.Y) / 2#
            pic.FontSize = 15
            pic.ForeColor = RGB(0, 0, 300)
            pic.Print "Z"
            pic.ForeColor = RGB(0, 0, 0)
            pic.FontSize = 8
        pic.DrawMode = 9
        pic.DrawStyle = 0
        
    End If
    End If
    
        p1.x = 0
        p1.Y = xyp.y_max
        p2 = map_pointto_xyplane(p1, xyp)
        p2.x = p2.x + (1 + 4) * 80
        p2.Y = p2.Y - (lline.cnt - 0.5) * 16
        pic.ForeColor = RGB(0, 0, 200)
        pic.FontUnderline = True
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print "RESULT"
        pic.FontUnderline = False
    If Not dup Then
        p2.Y = p2.Y + 16
        tmp = IIf(lline.ismax, "MAX(Z)=", "MIN(Z)=") & Trim(str(Round(res, 6))) & "."
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print tmp
        tmp = "AT POINT (" & Trim(str(Round(intsec.corners(indx).x, 6))) & "," & Trim(str(Round(intsec.corners(indx).Y, 6))) & ")."
        p2.Y = p2.Y + 16
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print tmp
    Else
        p2.Y = p2.Y + 16
        tmp = IIf(lline.ismax, "MAX(Z)=", "MIN(Z)=") & Trim(str(Round(res, 6))) & ".(INFINITE NUMBER OF SOLUTIONS)"
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print tmp
        tmp = "A PARTICULAR POINT IS (" & Trim(str(Round(intsec.corners(indx).x, 6))) & "," & Trim(str(Round(intsec.corners(indx).Y, 6))) & ")."
        p2.Y = p2.Y + 16
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print tmp
    End If
Else
        p1.x = 0
        p1.Y = xyp.y_max
        p2 = map_pointto_xyplane(p1, xyp)
        p2.x = p2.x + (1 + 4) * 80
        p2.Y = p2.Y - (lline.cnt - 0.5) * 16
        tmp = IIf(lline.ismax, "MAX(Z)=", "MIN(Z)=") & IIf(lline.common_region, "Unbounded Solution.", "No common region exists")
        pic.ForeColor = RGB(0, 0, 200)
        pic.FontUnderline = True
        pic.CurrentX = p2.x
        pic.CurrentY = p2.Y
        pic.Print tmp
End If
                                     
pic.DrawMode = 9
pic.DrawStyle = 0
pic.FontBold = True
pic.FontItalic = False
pic.FontSize = 7
pic.FontName = "courier new"
pic.ForeColor = RGB(0, 0, 0)
 pic.FontUnderline = False
 
l = 150
m = 25
n = 75
i = lline.cnt - 4
While i >= 0
    tmpl = n
    n = m
    m = l
    l = tmpl
    If lline.endpoints(i).x0_valid And lline.endpoints(i).y0_valid Then
        p1 = lline.endpoints(i).x0
        p2 = lline.endpoints(i).y0
        p1 = map_pointto_xyplane(p1, xyp)
        p2 = map_pointto_xyplane(p2, xyp)
        pic.Line (p1.x, p1.Y)-(p2.x, p2.Y), IIf(i <= lline.cnt - 4, RGB(l, m, n), RGB(250, 0, 0))
        pic.Line (p1.x, p1.Y)-(p2.x, p2.Y), IIf(i <= lline.cnt - 4, RGB(l, m, n), RGB(250, 0, 0))
        If lline.cnt - 4 >= i Then
            pic.CurrentX = (p1.x + p2.x) / 2#
            pic.CurrentY = (p1.Y + p2.Y) / 2#
            pic.Print "L" & Trim(str(i + 1))
        End If
    End If
    i = i - 1
Wend

i = 0
While i <= cor.cnt - 1
    p2 = map_pointto_xyplane(cor.corners(i), xyp)
    tmp = "(" & Trim(str(Round(cor.corners(i).x, 4))) & "," & Trim(str(Round(cor.corners(i).Y, 4))) & ")"
    If p2.x + Len(tmp) * 7 > pic.ScaleWidth Then p2.x = p2.x - (Len(tmp) * 7) / 2#
    pic.CurrentX = p2.x
    pic.CurrentY = p2.Y
    pic.Print tmp
    i = i + 1
Wend

End Sub

Private Sub fill_bndry(xyp As xy_plane, lline As lpp_lines, cor As corner_points, intsec As corner_points, tmpend As end_points, pic As PictureBox)
Dim i As Double
Dim j As Double
Dim k As Double
Dim lmt As Double
Dim tmpp As point
Dim p2 As point
   
    tmpp.x = xyp.x_max / 200#
    tmpp.Y = xyp.y_max / 200#
    For i = tmpend.x0.x To tmpend.y0.x Step tmpp.x
        For j = tmpend.x0.Y To tmpend.y0.Y Step tmpp.Y
             For k = 0 To lline.cnt Step 1
                lmt = lline.lines(k).x1 * i + lline.lines(k).x2 * j
                With lline.lines(k)
                If Not (IIf((.eq_type = 0 And .const = lmt) Or (.eq_type = -1 And lmt < .const) Or (.eq_type = 1 And lmt > .const), True, False)) Then
                    Exit For
                End If
                End With
            Next k
            If k = lline.cnt + 1 Then
                  p2.x = i
                  p2.Y = j
                  p2 = map_pointto_xyplane(p2, xyp)
                  pic.PSet (p2.x, p2.Y), QBColor(12)
            End If
        Next j
    Next i
End Sub

Public Function initiate_lpplines(pid As Long, xyp As xy_plane, lline As lpp_lines, cor As corner_points, intsec As corner_points, bndry As end_points, rintsec As corner_points) As Boolean
Dim Y As New Recordset
Dim tmpp As point
Dim j As Double
Dim k As Double
Dim i As Double
Dim inc As Double
Dim flg1 As Boolean
Dim flg2 As Boolean
Dim lmt As Double
Dim tmp As lpp_line
Dim tmpend As end_points
Dim li() As rat
Dim li_cnt As Long
Dim li1() As rat
Dim li_cnt1 As Long

initiate_lpplines = False
Call connect
Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & pid & "")
lline.cnt = -1
i = Y.Fields("m")
If Y.Fields("n") <> 2 Then
    Exit Function
End If
Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & pid & " and coid=0)")
lline.ismax = IIf(Y("e_type") = "MA", True, False)
Set Y = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & pid & " and coid=0) order by v_order")
Y.MoveFirst
lline.obj_x1 = Y.Fields("v_value")
Y.MoveNext
lline.obj_x2 = Y.Fields("v_value")
j = 1
Do While j <= i
    Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & pid & " and coid=" & j & ")")
    Y.MoveFirst
    tmp.eq_type = IIf(Y.Fields("e_type") = "GE", 1, IIf(Y.Fields("e_type") = "LE", -1, 0))
    
    Set Y = dn.cn.Execute("select v_value as vue from lpp_sub2 where" & _
        "(pid=" & pid & " and coid=" & j & ") order by v_order")
    
    Y.MoveFirst
    tmp.x1 = Round(Y.Fields("vue"), 8)
    Y.MoveNext
    tmp.x2 = Round(Y.Fields("vue"), 8)
    Y.MoveNext
    tmp.const = Round(Y.Fields("vue"), 8)
    
    If tmp.x1 = 0 And tmp.x2 = 0 Then
        Exit Function
    End If
    
    tmp.aline = linefrom_eqn(tmp.x1, tmp.x2, tmp.const)
    
    If Not tmp.aline.iserror Then
        If tmp.aline.xincpt Then
            tmpend.y0.Y = 0
            tmpend.y0.x = tmp.aline.c
            If tmpend.y0.x < 0 Then
                tmpend.y0_valid = False
            Else
                tmpend.y0_valid = True
            End If
            
            If tmp.aline.m <> 0 Then
                tmpend.x0.x = 0
                tmpend.x0.Y = -tmp.aline.c / tmp.aline.m
                If tmpend.x0.Y < 0 Or (tmpend.y0_valid And tmpend.x0.x = tmpend.y0.x And tmpend.x0.Y = tmpend.y0.Y) Then
                    tmpend.x0_valid = False
                Else
                    tmpend.x0_valid = True
                End If
            Else
                tmpend.x0_valid = False
            End If
        Else
            tmpend.x0.x = 0
            tmpend.x0.Y = tmp.aline.c
            If tmpend.x0.Y < 0 Then
                tmpend.x0_valid = False
            Else
                tmpend.x0_valid = True
            End If
            
            If tmp.aline.m <> 0 Then
                tmpend.y0.Y = 0
                tmpend.y0.x = -tmp.aline.c / tmp.aline.m
                If tmpend.y0.x < 0 Or (tmpend.x0_valid And tmpend.x0.x = tmpend.y0.x And tmpend.x0.Y = tmpend.y0.Y) Then
                    tmpend.y0_valid = False
                Else
                    tmpend.y0_valid = True
                End If
            Else
                tmpend.y0_valid = False
            End If
        End If
            lline.cnt = lline.cnt + 1
            If j <> 1 Then
                ReDim Preserve lline.lines(lline.cnt) As lpp_line
                ReDim Preserve lline.endpoints(lline.cnt) As end_points
            Else
                ReDim lline.lines(lline.cnt) As lpp_line
                ReDim lline.endpoints(lline.cnt) As end_points
            End If
            lline.lines(lline.cnt) = tmp
            lline.endpoints(lline.cnt) = tmpend
    End If
    j = j + 1
Loop

            lline.cnt = lline.cnt + 2
            ReDim Preserve lline.lines(lline.cnt) As lpp_line
            ReDim Preserve lline.endpoints(lline.cnt) As end_points

j = lline.cnt - 1
lline.lines(j).x1 = 1
lline.lines(j).x2 = 0
lline.lines(j).eq_type = 1
lline.lines(j).const = 0
lline.lines(j).aline.xincpt = True
lline.lines(j).aline.m = 0
lline.lines(j).aline.c = 0
lline.endpoints(j).y0.x = 0
lline.endpoints(j).y0.Y = 0
lline.endpoints(j).y0_valid = True
lline.endpoints(j).x0_valid = False

j = j + 1

lline.lines(j).x1 = 0
lline.lines(j).x2 = 1
lline.lines(j).eq_type = 1
lline.lines(j).const = 0
lline.lines(j).aline.xincpt = False
lline.lines(j).aline.m = 0
lline.lines(j).aline.c = 0
lline.endpoints(j).x0.x = 0
lline.endpoints(j).x0.Y = 0
lline.endpoints(j).x0_valid = True
lline.endpoints(j).y0_valid = False


flg1 = False
flg2 = False
For j = 0 To lline.cnt Step 1
    If lline.endpoints(j).y0_valid Then
        xyp.y_max = IIf(Not flg1, lline.endpoints(j).y0.Y, IIf(xyp.y_max < lline.endpoints(j).y0.Y, lline.endpoints(j).y0.Y, xyp.y_max))
        flg1 = True
    End If
    If lline.endpoints(j).x0_valid Then
        xyp.x_max = IIf(Not flg2, lline.endpoints(j).x0.x, IIf(xyp.x_max < lline.endpoints(j).x0.x, lline.endpoints(j).x0.x, xyp.x_max))
        flg2 = True
    End If
Next j

For i = 0 To lline.cnt - 1 Step 1
    For j = i + 1 To lline.cnt Step 1
        tmpp = find_intersection_point(lline.lines(i).aline, lline.lines(j).aline, tmp.aline.iserror)
        If tmp.aline.iserror And tmpp.x >= 0 And tmpp.Y >= 0 Then
            xyp.x_max = IIf(Not flg1, tmpp.x, IIf(tmpp.x > xyp.x_max, tmpp.x, xyp.x_max))
            flg1 = True
            xyp.y_max = IIf(Not flg2, tmpp.Y, IIf(tmpp.Y > xyp.y_max, tmpp.Y, xyp.y_max))
            flg2 = True
        End If
    Next j
Next i

xyp.x_max = xyp.x_max + (xyp.x_max / 10#)
xyp.y_max = xyp.y_max + (xyp.y_max / 10#)

For j = 0 To lline.cnt Step 1
    If Not lline.lines(j).aline.xincpt Then
        If Not lline.endpoints(j).x0_valid Then
            lline.endpoints(j).x0.x = xyp.x_max
            lline.endpoints(j).x0.Y = lline.lines(j).aline.m * xyp.x_max + lline.lines(j).aline.c
            If lline.endpoints(j).x0.Y < 0 Or lline.endpoints(j).x0.Y > xyp.y_max Then
                If lline.lines(j).aline.m <> 0 Then
                    lline.endpoints(j).x0.Y = xyp.y_max
                    lline.endpoints(j).x0.x = (xyp.y_max - lline.lines(j).aline.c) / lline.lines(j).aline.m
                    lline.endpoints(j).x0_valid = True
                Else
                    lline.endpoints(j).x0_valid = False
                End If
            Else
                 lline.endpoints(j).x0_valid = True
            End If
        End If
        
        If Not lline.endpoints(j).y0_valid Then
            lline.endpoints(j).y0.x = xyp.x_max
            lline.endpoints(j).y0.Y = lline.lines(j).aline.m * xyp.x_max + lline.lines(j).aline.c
            If lline.endpoints(j).y0.Y < 0 Or lline.endpoints(j).y0.Y > xyp.y_max Then
                If lline.lines(j).aline.m <> 0 Then
                    lline.endpoints(j).y0.Y = xyp.y_max
                    lline.endpoints(j).y0.x = (xyp.y_max - lline.lines(j).aline.c) / lline.lines(j).aline.m
                    lline.endpoints(j).y0_valid = True
                Else
                    lline.endpoints(j).y0_valid = False
                End If
            Else
                 lline.endpoints(j).y0_valid = True
            End If
        End If
    Else
        If Not lline.endpoints(j).y0_valid Then
            lline.endpoints(j).y0.Y = xyp.y_max
            lline.endpoints(j).y0.x = lline.lines(j).aline.m * xyp.y_max + lline.lines(j).aline.c
            If lline.endpoints(j).y0.x < 0 Or lline.endpoints(j).y0.x > xyp.x_max Then
                If lline.lines(j).aline.m <> 0 Then
                    lline.endpoints(j).y0.x = xyp.x_max
                    lline.endpoints(j).y0.Y = (xyp.x_max - lline.lines(j).aline.c) / lline.lines(j).aline.m
                    lline.endpoints(j).y0_valid = True
                Else
                    lline.endpoints(j).y0_valid = False
                End If
            Else
                 lline.endpoints(j).y0_valid = True
            End If
        End If
        
        If Not lline.endpoints(j).x0_valid Then
            lline.endpoints(j).x0.Y = xyp.y_max
            lline.endpoints(j).x0.x = lline.lines(j).aline.m * xyp.y_max + lline.lines(j).aline.c
            If lline.endpoints(j).x0.x < 0 Or lline.endpoints(j).x0.x > xyp.x_max Then
                If lline.lines(j).aline.m <> 0 Then
                    lline.endpoints(j).x0.x = xyp.x_max
                    lline.endpoints(j).x0.Y = (xyp.x_max - lline.lines(j).aline.c) / lline.lines(j).aline.m
                    lline.endpoints(j).x0_valid = True
                Else
                    lline.endpoints(j).x0_valid = False
                End If
            Else
                 lline.endpoints(j).x0_valid = True
            End If
        End If
    
    End If
Next j


            lline.cnt = lline.cnt + 2
            ReDim Preserve lline.lines(lline.cnt) As lpp_line
            ReDim Preserve lline.endpoints(lline.cnt) As end_points

j = lline.cnt - 1
lline.lines(j).x1 = 1
lline.lines(j).x2 = 0
lline.lines(j).eq_type = -1
lline.lines(j).const = xyp.x_max
lline.lines(j).aline.xincpt = True
lline.lines(j).aline.m = 0
lline.lines(j).aline.c = xyp.x_max
lline.endpoints(j).x0.x = xyp.x_max
lline.endpoints(j).x0.Y = 0
lline.endpoints(j).y0.x = xyp.x_max
lline.endpoints(j).y0.Y = xyp.y_max
lline.endpoints(j).y0_valid = True
lline.endpoints(j).x0_valid = False

j = j + 1

lline.lines(j).x1 = 0
lline.lines(j).x2 = 1
lline.lines(j).eq_type = -1
lline.lines(j).const = xyp.y_max
lline.lines(j).aline.xincpt = False
lline.lines(j).aline.m = 0
lline.lines(j).aline.c = xyp.y_max
lline.endpoints(j).x0.x = 0
lline.endpoints(j).x0.Y = xyp.y_max
lline.endpoints(j).y0.x = xyp.x_max
lline.endpoints(j).y0.Y = xyp.y_max
lline.endpoints(j).x0_valid = True
lline.endpoints(j).y0_valid = True


lline.inner_region = False
lline.common_region = False
intsec.cnt = -1
rintsec.cnt = -1
cor.cnt = -1
li_cnt = -1
li_cnt1 = -1
For i = 0 To lline.cnt - 1 Step 1
    For j = i + 1 To lline.cnt Step 1
        tmpp = find_intersection_point(lline.lines(i).aline, lline.lines(j).aline, tmp.aline.iserror)
        If tmp.aline.iserror And tmpp.x >= 0 And tmpp.Y >= 0 Then
            cor.cnt = cor.cnt + 1
            ReDim Preserve cor.corners(cor.cnt) As point
            cor.corners(cor.cnt).x = tmpp.x
            cor.corners(cor.cnt).Y = tmpp.Y
            For k = 0 To lline.cnt Step 1
                lmt = lline.lines(k).x1 * tmpp.x + lline.lines(k).x2 * tmpp.Y
                With lline.lines(k)
                If Not (IIf((.eq_type = 0 And Round(.const, 6) = Round(lmt, 6)) Or (.eq_type = -1 And Round(lmt, 6) <= Round(.const, 6)) Or (.eq_type = 1 And Round(lmt, 6) >= Round(.const, 6)), True, False)) Then
                    Exit For
                End If
                End With
            Next k
            If k = lline.cnt + 1 Then
                If Not lline.ismax Or (lline.ismax And i <= lline.cnt - 1 - 2 And j <= lline.cnt - 2) Then
                        intsec.cnt = intsec.cnt + 1
                        li_cnt = li_cnt + 1
                        ReDim Preserve li(li_cnt) As rat
                        li(li_cnt).a = i + 1
                        li(li_cnt).b = j + 1
                        ReDim Preserve intsec.corners(intsec.cnt) As point
                        intsec.corners(intsec.cnt).x = tmpp.x
                        intsec.corners(intsec.cnt).Y = tmpp.Y
                End If
                rintsec.cnt = rintsec.cnt + 1
                li_cnt1 = li_cnt1 + 1
                ReDim Preserve li1(li_cnt1) As rat
                li1(li_cnt1).a = i + 1
                li1(li_cnt1).b = j + 1
                ReDim Preserve rintsec.corners(rintsec.cnt) As point
                rintsec.corners(rintsec.cnt).x = tmpp.x
                rintsec.corners(rintsec.cnt).Y = tmpp.Y
            End If
        End If
    Next j
Next i

lline.common_region = isclosed_region(rintsec, li1)
If lline.common_region Then
     For i = 0 To rintsec.cnt Step 1
        bndry.x0.x = IIf(i = 0, rintsec.corners(0).x, IIf(bndry.x0.x > rintsec.corners(i).x, rintsec.corners(i).x, bndry.x0.x))
        bndry.y0.x = IIf(i = 0, rintsec.corners(0).x, IIf(bndry.y0.x < rintsec.corners(i).x, rintsec.corners(i).x, bndry.y0.x))
        bndry.x0.Y = IIf(i = 0, rintsec.corners(0).Y, IIf(bndry.x0.Y > rintsec.corners(i).Y, rintsec.corners(i).Y, bndry.x0.Y))
        bndry.y0.Y = IIf(i = 0, rintsec.corners(0).Y, IIf(bndry.y0.Y < rintsec.corners(i).Y, rintsec.corners(i).Y, bndry.y0.Y))
    Next i
End If
lline.inner_region = isclosed_region(intsec, li)
      
initiate_lpplines = True
End Function
Public Sub compact_points_simple(ByRef ps() As point, ByRef pcnt As Long)
Dim i As Long
Dim j As Long
Dim k As Long
Dim l As real_line

i = 0
Do While i <= pcnt - 1
    j = i + 1
    Do While j <= pcnt
        If ps(i).x = ps(j).x And ps(i).Y = ps(j).Y Then
            k = j
            Do While k <= pcnt - 1
                ps(k).x = ps(k + 1).x
                ps(k).Y = ps(k + 1).Y
                k = k + 1
            Loop
            pcnt = pcnt - 1
            ReDim Preserve ps(pcnt) As point
        Else
            j = j + 1
        End If
    Loop
    i = i + 1
Loop
End Sub

Public Function isuniqepoints(cor As corner_points, li() As rat) As Boolean
Dim i As Long
Dim j As Long

    For i = 0 To cor.cnt - 1 Step 1
        For j = i + 1 To cor.cnt Step 1
            If Round(cor.corners(i).x, 6) = Round(cor.corners(j).x, 6) And Round(cor.corners(i).Y, 6) = Round(cor.corners(j).Y, 6) Then
                isuniqepoints = False
                Exit Function
            End If
        Next j
    Next i
    isuniqepoints = True
End Function

Public Sub compact_points(cor As corner_points, li() As rat)
Dim i As Long
Dim j As Long
Dim k As Long
Dim f1 As Boolean
Dim f2 As Boolean

i = 0
While Not isuniqepoints(cor, li)
    f1 = False
    f2 = False
    For j = 0 To cor.cnt Step 1
        If i <> j And (Round(cor.corners(i).x, 6) <> Round(cor.corners(j).x, 6) Or Round(cor.corners(i).Y, 6) <> Round(cor.corners(j).Y, 6)) And (Round(li(i).a, 1) = Round(li(j).a, 1) Or Round(li(i).a, 1) = Round(li(j).b, 1)) Then
            f1 = True
            Exit For
        End If
    Next j
    For j = 0 To cor.cnt Step 1
        If i <> j And (Round(cor.corners(i).x, 6) <> Round(cor.corners(j).x, 6) Or Round(cor.corners(i).Y, 6) <> Round(cor.corners(j).Y, 6)) And (Round(li(i).b, 1) = Round(li(j).a, 1) Or Round(li(i).b, 0) = Round(li(j).b, 0)) Then
            f2 = True
            Exit For
        End If
    Next j
    If f1 And f2 Then
        i = (i + 1) Mod (cor.cnt + 1)
    Else
        For j = i To cor.cnt - 1 Step 1
            cor.corners(j) = cor.corners(j + 1)
            li(j) = li(j + 1)
        Next j
        ReDim Preserve cor.corners(cor.cnt - 1) As point
        ReDim Preserve li(cor.cnt - 1) As rat
        cor.cnt = cor.cnt - 1
        If i > cor.cnt Then i = 0
    End If
Wend
End Sub

Public Function isclosed_region(cor As corner_points, li() As rat) As Boolean
Dim iscrossed() As Boolean
Dim tocheck As Currency
Dim snode As Currency
Dim i As Long
Dim j As Long
       
    If cor.cnt <= -1 Then
        isclosed_region = False
        Exit Function
    End If
    Call compact_points(cor, li)
    ReDim iscrossed(cor.cnt) As Boolean
    For i = 0 To cor.cnt Step 1
        iscrossed(i) = False
    Next i
    snode = Round(li(0).a, 2)
    tocheck = Round(li(0).b, 2)
    iscrossed(0) = True
    j = 0
    While j <= cor.cnt
        For i = 0 To cor.cnt Step 1
            If Not iscrossed(i) Then
                If Round(tocheck, 2) = Round(li(i).a, 2) Then
                    iscrossed(i) = True
                    tocheck = Round(li(i).b, 2)
                ElseIf Round(tocheck, 2) = Round(li(i).b, 2) Then
                    iscrossed(i) = True
                    tocheck = Round(li(i).a, 2)
                End If
            End If
        Next i
        j = j + 1
    Wend
    If Round(snode, 2) = Round(tocheck, 2) Then
        isclosed_region = True
    Else
        isclosed_region = False
    End If
End Function

'---------------------------------------------------

Public Function create_line(x1 As Double, y1 As Double, x2 As Double, y2 As Double) As real_line
Dim e As real_line

    If x1 = x2 And y1 = y2 Then
        e.iserror = True
        create_line = e
        Exit Function
    End If

  e.iserror = False
  If x1 - x2 <> 0 Then
    e.m = (y1 - y2) / (x1 - x2)
    e.c = y1 - e.m * x1
    e.xincpt = False
  Else
    e.m = (x1 - x2) / (y1 - y2)
    e.c = x1 - e.m * y1
    e.xincpt = True
  End If
  
  create_line = e

End Function


Public Function provide_inpoint(xref As Double, yref As Double, xk As Double, yk As Double, dst _
As Double) As point
Dim rl As real_line
Dim p As point
Dim xp As Double
Dim yp As Double
Dim x_low As Double
Dim y_low As Double
Dim x_up As Double
Dim y_up As Double
Dim dist As Double

rl = create_line(xref, yref, xk, yk)
If rl.iserror Then
    p.x = -1
    p.Y = -1
    provide_inpoint = p
    Exit Function
End If

If rl.xincpt Then
    yp = yref + dst / Sqr(1 + rl.m * rl.m)
    xp = rl.m * yp + rl.c
Else
    xp = xref + dst / Sqr(1 + rl.m * rl.m)
    yp = rl.m * xp + rl.c
End If

x_low = xref
y_low = yref
dist = ((xref - xk) * (xref - xk) + (yref - yk) * (yref - yk)) ^ (1 / 2#)
If dst < dist Then
    x_up = xk
    y_up = yk
    p.x = xp
    p.Y = yp
Else
    x_up = xp
    y_up = yp
    p.x = xk
    p.Y = yk
End If

If x_up < x_low Then
    dist = x_up
    x_up = x_low
    x_low = dist
End If
If y_up < y_low Then
    dist = y_up
    y_up = y_low
    y_low = dist
End If

If x_low <= p.x And p.x <= x_up And y_low <= p.Y And p.Y <= y_up Then
    p.x = xp
    p.Y = yp
Else
    If rl.xincpt Then
        yp = yref - dst / Sqr(1 + rl.m * rl.m)
        xp = rl.m * yp + rl.c
    Else
        xp = xref - dst / Sqr(1 + rl.m * rl.m)
        yp = rl.m * xp + rl.c
    End If
    p.x = xp
    p.Y = yp
End If

provide_inpoint = p

End Function


Public Sub provide_arrow(p1 As point, p2 As point, dig As Double, pic As PictureBox, clr As _
Long, xyp As xy_plane, onlyone As Boolean, dst As Double)

Dim inpoint As point
Dim x_ As Double
Dim y_ As Double
Dim x As Double
Dim Y As Double
Dim xf As Double
Dim yf As Double
Dim icnt As Integer
Dim ocnt As Integer
Dim rad As Double
Dim p11 As point
Dim p22 As point

xf = p1.x
yf = p1.Y
x = p2.x
Y = p2.Y
ocnt = 1
Do While ocnt <= 2
    icnt = 1
    rad = dig
    Do While icnt <= 2
        x_ = xf + (x - xf) * Cos(rad * 3.14159 / 180#) - (Y - yf) * Sin(rad * 3.14159 / 180#)
        y_ = yf + (x - xf) * Sin(rad * 3.14159 / 180#) + (Y - yf) * Cos(rad * 3.14159 / 180#)
        inpoint = provide_inpoint(xf, yf, x_, y_, dst)
        p11 = map_pointto_xyplane(inpoint, xyp)
        p22.x = xf
        p22.Y = yf
        p22 = map_pointto_xyplane(p22, xyp)
        pic.Line (p11.x, p11.Y)-(p22.x, p22.Y), clr
        rad = -rad
        icnt = icnt + 1
    Loop
    ocnt = ocnt + 1
    If onlyone And ocnt > 1 Then
        Exit Do
    Else
        xf = p2.x
        yf = p2.Y
        x = p1.x
        Y = p1.Y
    End If
Loop

End Sub


Public Function linefrom_eqn(xcoeff As Double, ycoeff As Double, constant As Double) As real_line
Dim l As real_line

l.iserror = False
If ycoeff <> 0 Then
    l.m = -xcoeff / ycoeff
    l.c = constant / ycoeff
    l.xincpt = False
ElseIf xcoeff <> 0 Then
    l.m = -ycoeff / xcoeff
    l.c = constant / xcoeff
    l.xincpt = True
Else
    l.iserror = True
End If

linefrom_eqn = l

End Function
        

Public Function find_intersection_point(l1 As real_line, l2 As real_line, isxist As Boolean) As point

Dim p As point

isxist = True
If l1.xincpt And l2.xincpt Then
    If l1.m = l2.m Then
        isxist = False
    Else
        p.Y = -(l1.c - l2.c) / (l1.m - l2.m)
        p.x = IIf(l2.m * p.Y + l2.c >= 0, l2.m * p.Y + l2.c, l1.m * p.Y + l1.c)
        find_intersection_point = p
    End If
    Exit Function
ElseIf Not l1.xincpt And Not l2.xincpt Then
    If l1.m = l2.m Then
        isxist = False
    Else
        p.x = -(l1.c - l2.c) / (l1.m - l2.m)
        p.Y = IIf(l2.m * p.x + l2.c >= 0, l2.m * p.x + l2.c, l1.m * p.x + l1.c)
        find_intersection_point = p
    End If
    Exit Function
ElseIf Not l1.xincpt And l2.xincpt Then
    If l1.m * l2.m = 1 Then
        isxist = False
    Else
        p.Y = (l1.m * l2.c + l1.c) / (1 - l1.m * l2.m)
        p.x = l2.m * p.Y + l2.c
        find_intersection_point = p
    End If
    Exit Function
ElseIf l1.xincpt And Not l2.xincpt Then
    If l1.m * l2.m = 1 Then
        isxist = False
    Else
        p.Y = (l2.m * l1.c + l2.c) / (1 - l1.m * l2.m)
        p.x = l1.m * p.Y + l1.c
        find_intersection_point = p
    End If
    Exit Function
Else
    isxist = False
End If

End Function

              
'---------------------------------------------------

Public Sub dualsimplex_make_matrix(pid As Long, vars As Integer, cons As Integer, lpp_max As Boolean, lpp_matrix() As Double, lpp_rows As Long, lpp_cols As Long, lpp_obj() As Double, lpp_penalty() As Boolean, lpp_base() As Double, lpp_bases As Long, tots As Long)
Dim Y As New Recordset
Dim y1 As New Recordset
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim slak_surp As Integer
Dim l As Integer
Dim n As Integer
Dim m As Integer
Dim tflg As Integer

Call connect
Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & pid & "")
n = Y("n")
m = Y("m")
vars = n
cons = m
Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & pid & " and coid=0)")
tflg = IIf(Y("e_type") = "MA", 1, -1)
lpp_max = IIf(tflg = 1, True, False)
Set Y = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & pid & " and coid=0) order by v_order")
i = 0
tots = n - 1
ReDim lpp_obj(1, n - 1) As Double
ReDim lpp_penalty(n - 1) As Boolean
Y.MoveFirst
While Not Y.EOF
    lpp_obj(0, i) = i + 1
    lpp_obj(1, i) = Round(tflg * Y.Fields("v_value"), 8)
    lpp_penalty(i) = False
    i = i + 1
    Y.MoveNext
Wend
j = 0
ReDim lpp_matrix(m - 1, n) As Double
While j <= m - 1
    Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & pid & " and coid=" & j + 1 & ")")
    tflg = IIf(Y.Fields("e_type") = "GE", -1, 1)
    Set Y = dn.cn.Execute("select v_value as vue from lpp_sub2 where" & _
        "(pid=" & pid & " and coid=" & j + 1 & ") order by v_order")
    k = 1
    Y.MoveFirst
    While k <= n
        lpp_matrix(j, k) = Round(tflg * Y.Fields("vue"), 8)
        k = k + 1
        Y.MoveNext
    Wend
    lpp_matrix(j, 0) = Round(tflg * Y.Fields("vue"), 8)
    j = j + 1
Wend
Set Y = dn.cn.Execute("select e_type as ty,coid as id from lpp_sub1 where" & _
    "(pid=" & pid & " and coid<>0) order by coid")

k = 0
Y.MoveFirst
While Not Y.EOF
    k = k + 1
    Y.MoveNext
Wend
tots = n + k - 1
lpp_rows = m - 1
lpp_cols = n + k
ReDim Preserve lpp_obj(1, tots) As Double
ReDim Preserve lpp_penalty(tots) As Boolean
ReDim Preserve lpp_matrix(lpp_rows, lpp_cols) As Double
slak_surp = k
Y.MoveFirst
j = n + 1
i = 0
l = 0
While Not Y.EOF
    For k = n + 1 To n + slak_surp Step 1
        lpp_matrix(i, k) = 0
    Next k
    If Y.Fields("ty") = "LE" Or Y.Fields("ty") = "GE" Then
        ReDim Preserve lpp_base(l) As Double
        lpp_base(l) = j
        lpp_matrix(i, j) = 1
        lpp_obj(0, j - 1) = j
        lpp_obj(1, j - 1) = 0
        lpp_penalty(j - 1) = False
        j = j + 1
        l = l + 1
    End If
    If Y.Fields("ty") = "EQ" Then
        ReDim Preserve lpp_base(l) As Double
        lpp_base(l) = j
        lpp_matrix(i, j) = 1
        lpp_obj(0, j - 1) = j
        lpp_obj(1, j - 1) = -1
        lpp_penalty(j - 1) = True
        j = j + 1
        l = l + 1
    End If
    i = i + 1
Y.MoveNext
Wend
lpp_bases = l - 1
End Sub

Public Function make_stdlpp(pid As Long, rstd As lpp_ints) As std_lpp
Dim Y As New Recordset
Dim stdlpp As std_lpp
Dim stdlpp1 As std_lpp
Dim i As Long
Dim i1 As Long
Dim j As Long
Dim k As Long

Call connect
Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & pid & "")
stdlpp.n = Y("n")
stdlpp.m = Y("m")
Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & pid & " and coid=0)")
stdlpp.ismax = IIf(Y("e_type") = "MA", True, False)
Set Y = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & pid & " and coid=0) order by v_order")
i = 0
ReDim stdlpp.obj(1, stdlpp.n - 1) As Double
Y.MoveFirst
While Not Y.EOF
    stdlpp.obj(0, i) = i + 1
    stdlpp.obj(1, i) = Round(Y.Fields("v_value"), 8)
    i = i + 1
    Y.MoveNext
Wend
j = 0
ReDim stdlpp.lpp(stdlpp.m - 1, stdlpp.n) As Double
While j <= stdlpp.m - 1
    Set Y = dn.cn.Execute("select v_value as vue from lpp_sub2 where" & _
        "(pid=" & pid & " and coid=" & j + 1 & ") order by v_order")
    
    k = 1
    Y.MoveFirst
    While k <= stdlpp.n
        stdlpp.lpp(j, k) = Round(Y.Fields("vue"), 8)
        k = k + 1
        Y.MoveNext
    Wend
    stdlpp.lpp(j, 0) = Abs(Round(Y.Fields("vue"), 8))
    j = j + 1
Wend

ReDim stdlpp.rel(stdlpp.m - 1) As Integer
i = 0
Set Y = dn.cn.Execute("select e_type,coid from lpp_sub1 where" & _
    "(pid=" & pid & " and coid<>0) order by coid")

Y.MoveFirst
While Not Y.EOF
    stdlpp.rel(i) = IIf(Y.Fields("e_type") = "LE", -1, IIf(Y.Fields("e_type") = "GE", 1, 0))
    i = i + 1
    Y.MoveNext
Wend

i1 = 0
For i = 0 To stdlpp.n - 1 Step 1
    If rstd.isint(i) Then i1 = i1 + 1
Next i
j = 0
For i = 0 To stdlpp.m - 1 Step 1
    If stdlpp.rel(i) = 0 Then j = j + 1
Next i

stdlpp1.n = stdlpp.n
stdlpp1.m = stdlpp.m
ReDim stdlpp1.is_unrestricted(stdlpp1.m + j) As Boolean
ReDim stdlpp1.unrestricted(stdlpp1.m + j) As Long
ReDim stdlpp1.lpp(stdlpp1.m + j, stdlpp1.n + i1 + 1)
ReDim stdlpp1.obj(1, stdlpp1.n + i1)
ReDim stdlpp1.rel(stdlpp1.m + j)


For i = 0 To stdlpp1.m - 1
    stdlpp1.lpp(i, 0) = stdlpp.lpp(i, 0)
    stdlpp1.rel(i) = stdlpp.rel(i)
Next i

i1 = 0
For i = 0 To stdlpp.n - 1 Step 1
    stdlpp1.obj(0, i1) = stdlpp.obj(0, i)
    stdlpp1.obj(1, i1) = stdlpp.obj(1, i)
    For j = 0 To stdlpp.m - 1 Step 1
        stdlpp1.lpp(j, i1 + 1) = stdlpp.lpp(j, i + 1)
    Next j
    i1 = i1 + 1
    If rstd.isint(i) Then
        stdlpp1.obj(0, i1) = -1
        stdlpp1.obj(1, i1) = -stdlpp.obj(1, i)
        For j = 0 To stdlpp1.m - 1 Step 1
            stdlpp1.lpp(j, i1 + 1) = -stdlpp.lpp(j, i + 1)
        Next j
        i1 = i1 + 1
    End If
Next i

stdlpp1.n = i1
stdlpp1.m = stdlpp.m
stdlpp1.ismax = stdlpp.ismax
i = 0
k = 1
While i < stdlpp1.m
    stdlpp1.is_unrestricted(i) = False
    If stdlpp1.rel(i) = 0 Then
        stdlpp1.is_unrestricted(i) = True
        stdlpp1.unrestricted(i) = k
        For j = stdlpp1.m - 1 To i Step -1
            stdlpp1.rel(j + 1) = stdlpp1.rel(j)
            For k = 0 To stdlpp1.n Step 1
                stdlpp1.lpp(j + 1, k) = stdlpp1.lpp(j, k)
            Next k
        Next j
        If Not stdlpp1.ismax Then
            stdlpp1.rel(i) = 1
            stdlpp1.rel(i + 1) = -1
        Else
            stdlpp1.rel(i) = -1
            stdlpp1.rel(i + 1) = 1
        End If
        stdlpp1.m = stdlpp1.m + 1
    End If
    i = i + 1
    k = k + 1
Wend
      
      
For i = 0 To stdlpp1.m - 1 Step 1
    If (stdlpp1.ismax And stdlpp1.rel(i) = 1) Or (Not stdlpp1.ismax And stdlpp1.rel(i) = -1) Then
        For j = 0 To stdlpp1.n Step 1
            stdlpp1.lpp(i, j) = -stdlpp1.lpp(i, j)
        Next j
        stdlpp1.rel(i) = IIf(stdlpp1.ismax, 1, -1)
    End If
Next i
stdlpp1.ismax = Not stdlpp1.ismax
make_stdlpp = stdlpp1
End Function

Public Function make_dual(primal As std_lpp) As String
Dim i As Long
Dim j As Long
Dim k As Long
Dim dual As String

dual = vbCrLf & vbCrLf & Space(20) & IIf(Not primal.ismax, "MIN(Z*)=", "MAX(Z*)=")
i = 0
k = 1
While i <= primal.m - 1
    dual = dual & IIf(i <> 0 And primal.lpp(i, 0) >= 0, "+" & real_rat(primal.lpp(i, 0)) & "Y" & Trim(str(k)), real_rat(primal.lpp(i, 0)) & "Y" & Trim(str(k)))
    i = IIf(primal.is_unrestricted(i), i + 2, i + 1)
    k = k + 1
Wend

dual = dual & vbCrLf & vbCrLf & vbCrLf & Space(20) & "CONSTRAINTS:" & vbCrLf & vbCrLf & Space(25)

For j = 1 To primal.n Step 1
    k = 1
    i = 0
    While i <= primal.m - 1
        dual = dual & IIf(i <> 0 And primal.lpp(i, j) >= 0, "+" & real_rat(primal.lpp(i, j)) & "Y" & Trim(str(k)), real_rat(primal.lpp(i, j)) & "Y" & Trim(str(k)))
        i = IIf(primal.is_unrestricted(i), i + 2, i + 1)
        k = k + 1
    Wend
    dual = dual & IIf(primal.ismax, "<=", ">=") & Trim(real_rat(primal.obj(1, j - 1))) & vbCrLf & Space(25)
Next j

dual = dual & vbCrLf & vbCrLf & Space(20)
j = k - 1
For k = k - 1 To 1 Step -1
    dual = dual & "Y" & Trim(str(j - k) + 1) & ">=0" & IIf(k = 1, "", ",")
Next k

dual = dual & vbCrLf & vbCrLf
For i = 0 To primal.m - 1 Step 1
    If primal.is_unrestricted(i) Then
        dual = dual & vbCrLf & Space(20) & "Y" & Trim(str(primal.unrestricted(i))) & " IS UNRESTRICTED."
    End If
Next i
make_dual = dual
End Function

Public Sub simplex_make_matrix(pid As Long, vars As Integer, cons As Integer, lpp_max As Boolean, lpp_matrix() As Double, lpp_rows As Long, lpp_cols As Long, lpp_obj() As Double, lpp_penalty() As Boolean, lpp_base() As Double, lpp_bases As Long, tots As Long)
Dim Y As New Recordset
Dim y1 As New Recordset
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim slak_surp As Integer
Dim l As Integer
Dim n As Integer
Dim m As Integer
Dim tflg As Integer
Dim rel() As Integer


Call connect
Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & pid & "")
n = Y("n")
m = Y("m")
vars = n
cons = m
Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & pid & " and coid=0)")
tflg = IIf(Y("e_type") = "MA", 1, -1)
lpp_max = IIf(tflg = 1, True, False)
Set Y = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & pid & " and coid=0) order by v_order")
i = 0
tots = n - 1
ReDim lpp_obj(1, n - 1) As Double
ReDim lpp_penalty(n - 1) As Boolean
Y.MoveFirst
While Not Y.EOF
    lpp_obj(0, i) = i + 1
    lpp_obj(1, i) = Round(tflg * Y.Fields("v_value"), 8)
    lpp_penalty(i) = False
    i = i + 1
    Y.MoveNext
Wend
j = 0
ReDim lpp_matrix(m - 1, n) As Double
While j <= m - 1
    Set Y = dn.cn.Execute("select v_value as vue from lpp_sub2 where" & _
        "(pid=" & pid & " and coid=" & j + 1 & ") order by v_order")
    
    Y.MoveLast
    tflg = IIf(Y.Fields("vue") < 0, -1, 1)
    
    k = 1
    Y.MoveFirst
    While k <= n
        lpp_matrix(j, k) = tflg * Round(Y.Fields("vue"), 8)
        k = k + 1
        Y.MoveNext
    Wend
    lpp_matrix(j, 0) = Abs(Round(Y.Fields("vue"), 8))
    j = j + 1
Wend

ReDim rel(cons - 1) As Integer
k = 0
i = 0
Set Y = dn.cn.Execute("select e_type,coid from lpp_sub1 where" & _
    "(pid=" & pid & " and coid<>0) order by coid")

Y.MoveFirst
While Not Y.EOF
    rel(i) = IIf(Y.Fields("e_type") = "LE", -1, IIf(Y.Fields("e_type") = "GE", 1, 0))
    Set y1 = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & pid & " and coid=" & Y.Fields("coid") & " and v_order=" & vars + 1 & ")")
    If y1.Fields("v_value") < 0 Then rel(i) = rel(i) * -1
    k = k + IIf(rel(i) = -1, 1, IIf(rel(i) = 1, 2, 1))
    i = i + 1
    Y.MoveNext
Wend


tots = n + k - 1
lpp_rows = m - 1
lpp_cols = n + k
ReDim Preserve lpp_obj(1, tots) As Double
ReDim Preserve lpp_penalty(tots) As Boolean
ReDim Preserve lpp_matrix(lpp_rows, lpp_cols) As Double
slak_surp = k
Y.MoveFirst
j = n + 1
l = 0
For i = 0 To cons - 1 Step 1
    For k = n + 1 To n + slak_surp Step 1
        lpp_matrix(i, k) = 0
    Next k
    If rel(i) = -1 Then
        ReDim Preserve lpp_base(l) As Double
        lpp_base(l) = j
        lpp_matrix(i, j) = 1
        lpp_obj(0, j - 1) = j
        lpp_obj(1, j - 1) = 0
        lpp_penalty(j - 1) = False
        j = j + 1
        l = l + 1
    End If
    If rel(i) = 0 Then
        ReDim Preserve lpp_base(l) As Double
        lpp_base(l) = j
        lpp_matrix(i, j) = 1
        lpp_obj(0, j - 1) = j
        lpp_obj(1, j - 1) = -1
        lpp_penalty(j - 1) = True
        j = j + 1
        l = l + 1
    End If
    If rel(i) = 1 Then
        ReDim Preserve lpp_base(l) As Double
        lpp_base(l) = j + 1
        lpp_matrix(i, j) = -1
        lpp_matrix(i, j + 1) = 1
        lpp_obj(0, j - 1) = j
        lpp_obj(0, j) = j + 1
        lpp_obj(1, j - 1) = 0
        lpp_penalty(j - 1) = False
        lpp_obj(1, j) = -1
        lpp_penalty(j) = True
        j = j + 2
        l = l + 1
    End If
Next i

lpp_bases = l - 1
End Sub

Public Function dualsimplex_reload_tables(gup As MSHFlexGrid, gmid As MSHFlexGrid, gleft As MSHFlexGrid, gsol As MSHFlexGrid, vars As Integer, lpp_max As Boolean, Optional end_stat As Integer) As pivot
Dim p As pivot
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim cost_flg As Boolean
Dim tflg As Boolean
Dim net_flg As Boolean
Dim krow As Integer
Dim kcol As Integer
Dim prevm As String
Dim prevn As String
Dim t1 As String
Dim t2 As String

gsol.clear
net_flg = True
With gmid

For j = 1 To gmid.cols - 1 Step 1
    gmid.TextMatrix(gmid.rows - 4, j) = 0
    gmid.TextMatrix(gmid.rows - 5, j) = 0
    For i = 1 To gmid.rows - 7 Step 1
        If Trim(gleft.TextMatrix(i, 0)) = "-M" Then
            gmid.TextMatrix(gmid.rows - 5, j) = ratadd(gmid.TextMatrix(gmid.rows - 5, j), ratmul("-1", gmid.TextMatrix(i, j)))
        Else
            gmid.TextMatrix(gmid.rows - 4, j) = ratadd(gmid.TextMatrix(gmid.rows - 4, j), ratmul(gleft.TextMatrix(i, 0), gmid.TextMatrix(i, j)))
        End If
    Next i
    If Trim(gup.TextMatrix(0, j)) = "-M" Then
            gmid.TextMatrix(gmid.rows - 5, j) = ratadd(gmid.TextMatrix(gmid.rows - 5, j), "1")
    Else
           gmid.TextMatrix(gmid.rows - 4, j) = ratsub(gmid.TextMatrix(gmid.rows - 4, j), gup.TextMatrix(0, j))
    End If

    If rat_less0(.TextMatrix(.rows - 5, j)) Then
        net_flg = False
    Else
        If rat_eq0(.TextMatrix(.rows - 5, j)) And rat_less0(.TextMatrix(.rows - 4, j)) Then
            net_flg = False
        End If
    End If
Next j

cost_flg = False

For i = 1 To gleft.rows - 1 Step 1
    If rat_less0(gleft.TextMatrix(i, 2)) Then
        If Not cost_flg Then
            krow = i
            prevn = gleft.TextMatrix(i, 2)
            cost_flg = True
        Else
            If rat1_gret_rat2(prevn, gleft.TextMatrix(i, 2)) Then
                krow = i
                prevn = gleft.TextMatrix(i, 2)
                cost_flg = True
            End If
        End If
    End If
Next i

If Not cost_flg And net_flg Then
    
    If IsMissing(end_stat) Or end_stat = -1 Then
        MsgBox "Procedure Ended!!!,Obtained a Feasible Solution!!!", vbOKOnly, "SUCCESS!!!"
    Else
        end_stat = 0
    End If
    
    gsol.rows = 2
    gsol.cols = vars + 2
    gsol.FixedRows = 1
    gsol.FixedCols = 1
    For i = 1 To gsol.cols - 2 Step 1
        gsol.TextMatrix(0, i) = "X" & Trim(str(i))
        gsol.TextMatrix(1, i) = val_in_gleft(gleft, i)
    Next i
    gsol.TextMatrix(0, gsol.cols - 1) = IIf(lpp_max, "MAX(Z)", "MIN(Z)")
    gsol.TextMatrix(1, gsol.cols - 1) = 0
    For i = 1 To gleft.rows - 1 Step 1
        gsol.TextMatrix(1, gsol.cols - 1) = ratadd(gsol.TextMatrix(1, gsol.cols - 1), _
             ratmul(gleft.TextMatrix(i, 0), gleft.TextMatrix(i, 2)))
    Next i
    gsol.TextMatrix(1, gsol.cols - 1) = ratmul(gsol.TextMatrix(1, gsol.cols - 1), IIf(lpp_max, "1", "-1"))
    p.xist = False
    dualsimplex_reload_tables = p
    Exit Function
End If

If Not net_flg Then
    If IsMissing(end_stat) Or end_stat = -1 Then
        MsgBox "Procedure Ended(Method Failed,Net Evaluation<0)!!!,No solution Exists", vbOKOnly, "FAILURE!!!"
    Else
        end_stat = 1
    End If
    
    p.xist = False
    dualsimplex_reload_tables = p
    Exit Function
End If

tflg = False
For j = 1 To .cols - 1 Step 1
    If rat_less0(.TextMatrix(krow, j)) Then
        t1 = ratdiv(.TextMatrix(.rows - 5, j), .TextMatrix(krow, j))
        t2 = ratdiv(.TextMatrix(.rows - 4, j), .TextMatrix(krow, j))
        .TextMatrix(.rows - 2, j) = t1
        .TextMatrix(.rows - 1, j) = t2
        If Not tflg Then
            kcol = j
            prevm = t1
            prevn = t2
            tflg = True
        Else
            If rat1_gret_rat2(t1, prevm) Then
                kcol = j
                prevm = t1
                prevn = t2
            Else
                If rat1_equ_rat2(t1, prevm) And rat1_gret_rat2(t2, prevn) Then
                    kcol = j
                    prevm = t1
                    prevn = t2
                End If
            End If
        End If
    End If
Next j

If Not tflg Then
    If IsMissing(end_stat) Or end_stat = -1 Then
        MsgBox "Procedure Ended(Method Failed,Aik>0 for all k in the key row i)!!!." & vbCrLf & "No solution Exists", vbOKOnly, "FAILURE!!!"
    Else
        end_stat = 1
    End If
    p.xist = False
    dualsimplex_reload_tables = p
    Exit Function
End If
End With
For i = 0 To gsol.cols - 1 Step 1
    gsol.ColWidth(i) = 1200
Next i
p.xist = True
p.row = krow
p.col = kcol
gmid.row = krow
gmid.col = kcol
gmid.CellBackColor = RGB(300, 300, 0)
dualsimplex_reload_tables = p
If Not IsMissing(end_stat) Then end_stat = 2
End Function


Public Function simplex_reload_tables(gup As MSHFlexGrid, gmid As MSHFlexGrid, gleft As MSHFlexGrid, gsol As MSHFlexGrid, vars As Integer, lpp_max As Boolean, Optional end_stat As Integer) As pivot
Dim p As pivot
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim proceed_flg As Boolean
Dim tflg As Boolean
Dim succflg As Boolean
Dim krow As Integer
Dim kcol As Integer
Dim prevm As String
Dim prevn As String

gsol.clear
succflg = True
proceed_flg = False
With gmid

For j = 1 To gmid.cols - 2 Step 1
    gmid.TextMatrix(gmid.rows - 2, j) = 0
    gmid.TextMatrix(gmid.rows - 1, j) = 0
    For i = 1 To gmid.rows - 4 Step 1
        If gleft.TextMatrix(i, 0) = "-M" Then
            gmid.TextMatrix(gmid.rows - 2, j) = ratadd(gmid.TextMatrix(gmid.rows - 2, j), ratmul("-1", gmid.TextMatrix(i, j)))
        Else
            gmid.TextMatrix(gmid.rows - 1, j) = ratadd(gmid.TextMatrix(gmid.rows - 1, j), ratmul(gleft.TextMatrix(i, 0), gmid.TextMatrix(i, j)))
        End If
    Next i
    If gup.TextMatrix(0, j) = "-M" Then
            gmid.TextMatrix(gmid.rows - 2, j) = ratadd(gmid.TextMatrix(gmid.rows - 2, j), "1")
    Else
           gmid.TextMatrix(gmid.rows - 1, j) = ratsub(gmid.TextMatrix(gmid.rows - 1, j), gup.TextMatrix(0, j))
    End If

    
    tflg = True
    If rat_less0(.TextMatrix(.rows - 2, j)) Then
        tflg = tflg And True
        succflg = False
    Else
        If rat_gret0(.TextMatrix(.rows - 2, j)) Then
            tflg = tflg And False
        Else
            If rat_less0(.TextMatrix(.rows - 1, j)) Then
                tflg = tflg And True
                succflg = False
            Else
                tflg = tflg And False
            End If
        End If
    End If
    If tflg = True Then
        If proceed_flg = False Then
            prevm = .TextMatrix(.rows - 2, j)
            prevn = .TextMatrix(.rows - 1, j)
            kcol = j
        Else
            If rat1_less_rat2(.TextMatrix(.rows - 2, j), prevm) Then
                prevm = .TextMatrix(.rows - 2, j)
                prevn = .TextMatrix(.rows - 1, j)
                kcol = j
            Else
                If rat1_equ_rat2(.TextMatrix(.rows - 2, j), prevm) And rat1_less_rat2(.TextMatrix(.rows - 1, j), prevn) Then
                    prevm = .TextMatrix(.rows - 2, j)
                    prevn = .TextMatrix(.rows - 1, j)
                    kcol = j
                End If
            End If
        End If
    End If
    proceed_flg = proceed_flg Or tflg
Next j

If succflg Then
    For i = 1 To gleft.rows - 1 Step 1
        If Not rat_eq0(gleft.TextMatrix(i, 2)) Then
            If Trim(gleft.TextMatrix(i, 0)) = "-M" Then
                succflg = False
                Exit For
            End If
        End If
    Next i
    
    If Not succflg Then
        If IsMissing(end_stat) Or end_stat = -1 Then
            MsgBox "Procedure Ended!!!,No Feasible solution Exists." & vbCrLf & "PSEUDO OPTIMAL BASIC FEASIBLE SOLUTION", vbOKOnly, "FAILURE!!!"
        Else
            end_stat = 1
        End If
        p.xist = False
        simplex_reload_tables = p
        Exit Function
    End If
    
    If IsMissing(end_stat) Or end_stat = -1 Then
        MsgBox "Procedure Ended!!!,Obtained a Feasible Solution!!!", vbOKOnly, "SUCCESS!!!"
    Else
        end_stat = 0
    End If
    gsol.rows = 2
    gsol.cols = vars + 2
    gsol.FixedRows = 1
    gsol.FixedCols = 1
    For i = 1 To gsol.cols - 2 Step 1
        gsol.TextMatrix(0, i) = "X" & Trim(str(i))
        gsol.TextMatrix(1, i) = val_in_gleft(gleft, i)
    Next i
    gsol.TextMatrix(0, gsol.cols - 1) = IIf(lpp_max, "MAX(Z)", "MIN(Z)")
    gsol.TextMatrix(1, gsol.cols - 1) = 0
    For i = 1 To gleft.rows - 1 Step 1
        gsol.TextMatrix(1, gsol.cols - 1) = ratadd(gsol.TextMatrix(1, gsol.cols - 1), _
             ratmul(gleft.TextMatrix(i, 0), gleft.TextMatrix(i, 2)))
    Next i
    gsol.TextMatrix(1, gsol.cols - 1) = ratmul(gsol.TextMatrix(1, gsol.cols - 1), IIf(lpp_max, "1", "-1"))
    p.xist = False
    simplex_reload_tables = p
    Exit Function
End If

If proceed_flg = False Then
    If IsMissing(end_stat) Or end_stat = -1 Then
        MsgBox "Procedure Ended!!!,No solution Exists", vbOKOnly, "FAILURE!!!"
    Else
        end_stat = 1
    End If
    p.xist = False
    simplex_reload_tables = p
    Exit Function
End If

proceed_flg = False
For i = 1 To gmid.rows - 4 Step 1
    tflg = True
    If rat_leq0(.TextMatrix(i, kcol)) Then tflg = tflg And False
    If tflg = True Then
        prevm = ratdiv(gleft.TextMatrix(i, 2), .TextMatrix(i, kcol))
        If proceed_flg = False Then
            krow = i
            prevn = prevm
        Else
            If rat1_gret_rat2(prevn, prevm) Then
                krow = i
                prevn = prevm
            End If
        End If
        .TextMatrix(i, .cols - 1) = prevm
    End If
    proceed_flg = proceed_flg Or tflg
Next i

If proceed_flg = False Then
    If IsMissing(end_stat) Or end_stat = -1 Then
        MsgBox "Procedure Ended!!!,No solution Exists(Unbounded Solution)", vbOKOnly, "FAILURE!!!"
    Else
        end_stat = 1
    End If
    p.xist = False
    simplex_reload_tables = p
    Exit Function
End If
End With
For i = 0 To gsol.cols - 1 Step 1
    gsol.ColWidth(i) = 1200
Next i
p.xist = True
p.row = krow
p.col = kcol
gmid.row = krow
gmid.col = kcol
gmid.CellBackColor = RGB(300, 300, 0)
simplex_reload_tables = p
If Not IsMissing(end_stat) Then end_stat = 2
End Function

Public Sub dualsimplex_reduce_tounity(gleft As MSHFlexGrid, gmid As MSHFlexGrid, gup As MSHFlexGrid, piv As pivot)
Dim i As Integer
Dim j As Integer
Dim pi As String
Dim tmp_store As String

If Not piv.xist Then Exit Sub

gmid.row = piv.row
gmid.col = piv.col
gmid.CellBackColor = RGB(300, 300, 300)

For j = 1 To gmid.cols - 1 Step 1
    gmid.TextMatrix(gmid.rows - 1, j) = ""
    gmid.TextMatrix(gmid.rows - 2, j) = ""
    
    gmid.TextMatrix(gmid.rows - 4, j) = ""
    gmid.TextMatrix(gmid.rows - 5, j) = ""
Next j

pi = gmid.TextMatrix(piv.row, piv.col)

gleft.TextMatrix(piv.row, 0) = gup.TextMatrix(0, piv.col)
gleft.TextMatrix(piv.row, 1) = gup.TextMatrix(1, piv.col)
gleft.TextMatrix(piv.row, 2) = ratdiv(gleft.TextMatrix(piv.row, 2), pi)

For j = 1 To gmid.cols - 1 Step 1
    gmid.TextMatrix(piv.row, j) = ratdiv(gmid.TextMatrix(piv.row, j), pi)
Next j

For i = 1 To gmid.rows - 7 Step 1
    If Not i = piv.row Then
        tmp_store = gmid.TextMatrix(i, piv.col)
        gleft.TextMatrix(i, 2) = ratsub(gleft.TextMatrix(i, 2), ratmul(gleft.TextMatrix(piv.row, 2), tmp_store))
        For j = 1 To gmid.cols - 1 Step 1
            gmid.TextMatrix(i, j) = ratsub(gmid.TextMatrix(i, j), ratmul(gmid.TextMatrix(piv.row, j), tmp_store))
        Next j
    End If
Next i

End Sub

Public Sub simplex_reduce_tounity(gleft As MSHFlexGrid, gmid As MSHFlexGrid, gup As MSHFlexGrid, piv As pivot)
Dim i As Integer
Dim j As Integer
Dim pi As String
Dim tmp_store As String

If Not piv.xist Then Exit Sub

gmid.row = piv.row
gmid.col = piv.col
gmid.CellBackColor = RGB(300, 300, 300)

For i = 1 To gmid.rows - 4 Step 1
    gmid.TextMatrix(i, gmid.cols - 1) = ""
Next i

For j = 1 To gmid.cols - 2 Step 1
    gmid.TextMatrix(gmid.rows - 1, j) = ""
    gmid.TextMatrix(gmid.rows - 2, j) = ""
Next j

pi = gmid.TextMatrix(piv.row, piv.col)

gleft.TextMatrix(piv.row, 0) = gup.TextMatrix(0, piv.col)
gleft.TextMatrix(piv.row, 1) = gup.TextMatrix(1, piv.col)
gleft.TextMatrix(piv.row, 2) = ratdiv(gleft.TextMatrix(piv.row, 2), pi)

For j = 1 To gmid.cols - 2 Step 1
    gmid.TextMatrix(piv.row, j) = ratdiv(gmid.TextMatrix(piv.row, j), pi)
Next j

For i = 1 To gmid.rows - 4 Step 1
    If Not i = piv.row Then
        tmp_store = gmid.TextMatrix(i, piv.col)
        gleft.TextMatrix(i, 2) = ratsub(gleft.TextMatrix(i, 2), ratmul(gleft.TextMatrix(piv.row, 2), tmp_store))
        For j = 1 To gmid.cols - 2 Step 1
            gmid.TextMatrix(i, j) = ratsub(gmid.TextMatrix(i, j), ratmul(gmid.TextMatrix(piv.row, j), tmp_store))
        Next j
    End If
Next i

End Sub

Public Sub dualsimplex_load_tables(gup As MSHFlexGrid, gmid As MSHFlexGrid, gleft As MSHFlexGrid, vars As Integer, cons As Integer, lpp_max As Boolean, lpp_matrix() As Double, lpp_rows As Long, lpp_cols As Long, lpp_obj() As Double, lpp_penalty() As Boolean, lpp_base() As Double, lpp_bases As Long, tots As Long)
Dim i As Integer
Dim j As Integer
Dim slack As Long
Dim art As Long
Dim lmt As Long

gup.rows = 2
gup.cols = tots + 2
gup.FixedRows = 1
gup.FixedCols = 1
gup.TextMatrix(0, 0) = "COST(Cj)"
gup.TextMatrix(1, 0) = IIf(lpp_max, "MAX(Z)", "MIN(Z)")
slack = 1
art = 1
For i = 0 To tots Step 1
'    gup.TextMatrix(1, i + 1) = IIf(i + 1 <= vars, "Y" + Trim(str(lpp_obj(0, i))), "S" + Trim(str(lpp_obj(0, i) - vars)))
    If i + 1 <= vars Then
        gup.TextMatrix(1, i + 1) = "Y" + Trim(str(lpp_obj(0, i)))
    ElseIf lpp_penalty(i) Then
        gup.TextMatrix(1, i + 1) = "A" + Trim(str(art))
        art = art + 1
    Else
        gup.TextMatrix(1, i + 1) = "S" + Trim(str(slack))
        slack = slack + 1
    End If
    gup.TextMatrix(0, i + 1) = IIf(lpp_penalty(i), "-M", real_rat(Val(lpp_obj(1, i))))
Next i

gleft.cols = 3
gleft.rows = lpp_bases + 2
gleft.FixedRows = 1
gleft.TextMatrix(0, 0) = "COST(Cj)"
gleft.TextMatrix(0, 2) = "Xj"
gleft.TextMatrix(0, 1) = "Yj"
For i = 0 To lpp_bases Step 1
    gleft.TextMatrix(i + 1, 0) = IIf(lpp_penalty(lpp_base(i) - 1), "-M", real_rat(Val(lpp_obj(1, lpp_base(i) - 1))))
    If lpp_obj(0, lpp_base(i) - 1) <= vars Then
        gleft.TextMatrix(i + 1, 1) = Trim("Y" & Trim(str(lpp_base(i))))
    ElseIf lpp_penalty(lpp_base(i) - 1) Then
        art = 1
        If i = 0 Then
            lmt = -1
        Else
            lmt = lpp_base(i - 1) - 1
        End If
        For j = 0 To lmt Step 1
            If lpp_penalty(j) Then art = art + 1
        Next j
        gleft.TextMatrix(i + 1, 1) = "A" + Trim(str(art))
    Else
        slack = 1
        If i = 0 Then
            lmt = -1
        Else
            lmt = lpp_base(i - 1) - 1
        End If
        For j = vars + 1 To lmt Step 1
            If Not lpp_penalty(j) Then slack = slack + 1
        Next j
        gleft.TextMatrix(i + 1, 1) = "S" + Trim(str(slack))
    End If
'   gleft.TextMatrix(i + 1, 1) = IIf(lpp_obj(0, lpp_base(i) - 1) <= vars, Trim("Y" & Trim(str(lpp_base(i)))), Trim("S" & Trim(str(lpp_base(i) - vars))))
    gleft.TextMatrix(i + 1, 2) = real_rat(Val(lpp_matrix(find_index_inlppmatrix(lpp_base(i), lpp_matrix, lpp_rows), 0)))
Next i

gmid.rows = lpp_rows + 2 + 3 + 3
gmid.cols = lpp_cols + 1
gmid.FixedCols = 1
gmid.FixedRows = 1

art = 1
slack = 1
For j = 1 To gmid.cols - 1 Step 1
    If j <= vars Then
        gmid.TextMatrix(0, j) = "Y" + Trim(str(lpp_obj(0, j - 1)))
    ElseIf lpp_penalty(j - 1) Then
        gmid.TextMatrix(0, j) = "A" + Trim(str(art))
        art = art + 1
    Else
        gmid.TextMatrix(0, j) = "S" + Trim(str(slack))
        slack = slack + 1
    End If
    'gmid.TextMatrix(0, j) = IIf(j <= vars, Trim("Y" & Trim(str(j))), Trim("S" & Trim(str(j) - vars)))
Next j

For i = 0 To lpp_rows Step 1
    For j = 1 To lpp_cols Step 1
        gmid.TextMatrix(i + 1, j) = real_rat(lpp_matrix(i, j))
    Next j
Next i
i = i + 1
gmid.TextMatrix(i, 0) = "NER"
gmid.TextMatrix(i + 1, 0) = "(M)"
gmid.TextMatrix(i + 2, 0) = "(NON-M)"
gmid.TextMatrix(i + 3, 0) = "RATIO"
gmid.TextMatrix(i + 4, 0) = "(M)"
gmid.TextMatrix(i + 5, 0) = "(NON-M)"
For j = 0 To gmid.cols - 1 Step 1
    gmid.ColWidth(j) = 1200
Next j
End Sub

Public Sub simplex_load_tables(gup As MSHFlexGrid, gmid As MSHFlexGrid, gleft As MSHFlexGrid, vars As Integer, cons As Integer, lpp_max As Boolean, lpp_matrix() As Double, lpp_rows As Long, lpp_cols As Long, lpp_obj() As Double, lpp_penalty() As Boolean, lpp_base() As Double, lpp_bases As Long, tots As Long)
Dim i As Integer
Dim j As Integer
Dim slack As Long
Dim art As Long
Dim lmt As Long

gup.rows = 2
gup.cols = tots + 2
gup.FixedRows = 1
gup.FixedCols = 1
gup.TextMatrix(0, 0) = "COST(Cj)"
gup.TextMatrix(1, 0) = IIf(lpp_max, "MAX(Z)", "MIN(Z)")
'For i = 0 To tots Step 1
'    gup.TextMatrix(1, i + 1) = IIf(i + 1 <= vars, "Y" + Trim(str(lpp_obj(0, i))), "S" + Trim(str(lpp_obj(0, i) - vars)))
'    gup.TextMatrix(0, i + 1) = IIf(lpp_penalty(i), "-M", real_rat(Val(Trim(lpp_obj(1, i)))))
'Next i
slack = 1
art = 1
For i = 0 To tots Step 1
'    gup.TextMatrix(1, i + 1) = IIf(i + 1 <= vars, "Y" + Trim(str(lpp_obj(0, i))), "S" + Trim(str(lpp_obj(0, i) - vars)))
    If i + 1 <= vars Then
        gup.TextMatrix(1, i + 1) = "Y" + Trim(str(lpp_obj(0, i)))
    ElseIf lpp_penalty(i) Then
        gup.TextMatrix(1, i + 1) = "A" + Trim(str(art))
        art = art + 1
    Else
        gup.TextMatrix(1, i + 1) = "S" + Trim(str(slack))
        slack = slack + 1
    End If
    gup.TextMatrix(0, i + 1) = IIf(lpp_penalty(i), "-M", real_rat(Val(lpp_obj(1, i))))
Next i

gleft.cols = 3
gleft.rows = lpp_bases + 2
gleft.FixedRows = 1
gleft.TextMatrix(0, 0) = "COST(Cj)"
gleft.TextMatrix(0, 2) = "Xj"
gleft.TextMatrix(0, 1) = "Yj"
'For i = 0 To lpp_bases Step 1
'    gleft.TextMatrix(i + 1, 0) = IIf(lpp_penalty(lpp_base(i) - 1), "-M", real_rat(Val(Trim(lpp_obj(1, lpp_base(i) - 1)))))
'    gleft.TextMatrix(i + 1, 1) = IIf(lpp_obj(0, lpp_base(i) - 1) <= vars, Trim("Y" & Trim(str(lpp_base(i)))), Trim("S" & Trim(str(lpp_base(i) - vars))))
'    gleft.TextMatrix(i + 1, 2) = real_rat(Val(lpp_matrix(find_index_inlppmatrix(lpp_base(i), lpp_matrix(), lpp_rows), 0)))
'Next i
For i = 0 To lpp_bases Step 1
    gleft.TextMatrix(i + 1, 0) = IIf(lpp_penalty(lpp_base(i) - 1), "-M", real_rat(Val(lpp_obj(1, lpp_base(i) - 1))))
    If lpp_obj(0, lpp_base(i) - 1) <= vars Then
        gleft.TextMatrix(i + 1, 1) = Trim("Y" & Trim(str(lpp_base(i))))
    ElseIf lpp_penalty(lpp_base(i) - 1) Then
        art = 1
        If i = 0 Then
            lmt = -1
        Else
            lmt = lpp_base(i - 1) - 1
        End If
        For j = 0 To lmt Step 1
            If lpp_penalty(j) Then art = art + 1
        Next j
        gleft.TextMatrix(i + 1, 1) = "A" + Trim(str(art))
    Else
        slack = 1
        If i = 0 Then
            lmt = -1
        Else
            lmt = lpp_base(i - 1) - 1
        End If
        For j = vars + 1 To lmt Step 1
            If Not lpp_penalty(j) Then slack = slack + 1
        Next j
        gleft.TextMatrix(i + 1, 1) = "S" + Trim(str(slack))
    End If
'   gleft.TextMatrix(i + 1, 1) = IIf(lpp_obj(0, lpp_base(i) - 1) <= vars, Trim("Y" & Trim(str(lpp_base(i)))), Trim("S" & Trim(str(lpp_base(i) - vars))))
    gleft.TextMatrix(i + 1, 2) = real_rat(Val(lpp_matrix(find_index_inlppmatrix(lpp_base(i), lpp_matrix, lpp_rows), 0)))
Next i
gmid.rows = lpp_rows + 2 + 3
gmid.cols = lpp_cols + 1 + 1
gmid.FixedCols = 1
gmid.FixedRows = 1

'For j = 1 To gmid.cols - 2 Step 1
    'gmid.TextMatrix(0, j) = IIf(j <= vars, Trim("Y" & Trim(str(j))), Trim("S" & Trim(str(j) - vars)))
'Next j

art = 1
slack = 1
For j = 1 To gmid.cols - 2 Step 1
    If j <= vars Then
        gmid.TextMatrix(0, j) = "Y" + Trim(str(lpp_obj(0, j - 1)))
    ElseIf lpp_penalty(j - 1) Then
        gmid.TextMatrix(0, j) = "A" + Trim(str(art))
        art = art + 1
    Else
        gmid.TextMatrix(0, j) = "S" + Trim(str(slack))
        slack = slack + 1
    End If
    'gmid.TextMatrix(0, j) = IIf(j <= vars, Trim("Y" & Trim(str(j))), Trim("S" & Trim(str(j) - vars)))
Next j

gmid.TextMatrix(0, j) = "RATIO"

For i = 0 To lpp_rows Step 1
    For j = 1 To lpp_cols Step 1
        gmid.TextMatrix(i + 1, j) = real_rat(Round(lpp_matrix(i, j), 8))
    Next j
Next i
i = i + 1
gmid.TextMatrix(i, 0) = "NER"
gmid.TextMatrix(i + 1, 0) = "(M)"
gmid.TextMatrix(i + 2, 0) = "(NON-M)"

For j = 0 To gmid.cols - 1 Step 1
    gmid.ColWidth(j) = 1200
Next j
End Sub

Private Function find_index_inlppmatrix(var As Double, lpp_matrix() As Double, lpp_rows As Long) As Long
Dim i As Integer

For i = 0 To lpp_rows Step 1
    If lpp_matrix(i, var) = 1 Then
        find_index_inlppmatrix = i
        Exit Function
    End If
Next i
find_index_inlppmatrix = -1

End Function


'-------------Registry handling & Data Base Connecting-----------'


Public Function inregistry() As Boolean
Dim x As String
x = GetSetting("OT", "data_base", "exsist", "FALSE")
If x = "FALSE" Then
    inregistry = False
Else
    inregistry = True
End If
End Function

Public Sub add_to_registry(tprovide As String, tdat As String, tuserid As String, tpass As String)
      SaveSetting "OT", "data_base", "exsist", "TRUE"
      SaveSetting "OT", "data_base", "dprovider", tprovide
      SaveSetting "OT", "data_base", "dsource", tdat
      SaveSetting "OT", "data_base", "duser", tuserid
      SaveSetting "OT", "data_base", "dpass", tpass
End Sub

Public Sub del_registry()

If GetSetting("OT", "data_base", "exsist", "FALSE") = "TRUE" Then
      DeleteSetting "OT", "data_base", "exsist"
      DeleteSetting "OT", "data_base", "dprovider"
      DeleteSetting "OT", "data_base", "dsource"
      DeleteSetting "OT", "data_base", "duser"
      DeleteSetting "OT", "data_base", "dpass"
End If

End Sub

Public Sub addtocombobox(comb As ComboBox, rs As Recordset, field As String)

On Error GoTo cancel

comb.clear
If rs.RecordCount <= 0 Then Exit Sub
rs.MoveFirst
While Not rs.EOF
    comb.AddItem (Trim(rs.Fields(field)))
    rs.MoveNext
Wend
Exit Sub
cancel:
    MsgBox Err.Description
    
End Sub


Public Sub addtocombolist(comb As Control, rs As Recordset, f1 As String, f2 As String)
On Error GoTo cancel

comb.clear
If rs.RecordCount <= 0 Then Exit Sub
rs.MoveFirst
While Not rs.EOF
    comb.AddItem (Trim(rs.Fields(f1)))
    comb.ItemData(comb.NewIndex) = Val(rs.Fields(f2))
    rs.MoveNext
Wend
Exit Sub
cancel:
    MsgBox Err.Description
    
End Sub


Public Sub connect()
    
    If dn.cn.state = adStateClosed Then dn.cn.Open
    
End Sub

Public Function getmaxid(fld As String, tnam As String, pid As Long, pidselect As Boolean) As Long
On Error GoTo cancel
Dim rs As New Recordset

Call connect

If pidselect = False Then
    rs.Open "select * from " & tnam & "", dn.cn
Else
    rs.Open "select * from " & tnam & " where projid=" & pid & "", dn.cn
End If

If rs.RecordCount <= 0 Then
    getmaxid = 1
Else
    rs.Close
    If pidselect = True Then
        rs.Open "select max(" & fld & ") as maxi from " & tnam & " where projid=" & pid & "", dn.cn
    Else
        rs.Open "select max(" & fld & ") as maxi from " & tnam & "", dn.cn
    End If
    rs.MoveFirst
    getmaxid = (rs.Fields("maxi") + 1)
End If
Exit Function

cancel:
    MsgBox Err.Description
    getmaxid = 0
    
End Function

Public Function mixed_method_sub(gup As MSHFlexGrid, gmid As MSHFlexGrid, gleft As MSHFlexGrid, gsol As MSHFlexGrid, showcon As Boolean) As Boolean
Dim frac_x As Boolean
Dim max_frac As String
Dim krow As Integer
Dim i As Integer
Dim j As Integer
Dim tmp As String
Dim t1 As String
Dim t2 As String
Dim addcon As String

With gmid

frac_x = False
For i = 1 To gleft.rows - 1 Step 1
If restrictedtointeger(gleft, i) Then
    If rat_rat(gleft.TextMatrix(i, 2)) Then
        If Not frac_x Then
            frac_x = True
            krow = i
            max_frac = rat_properfractional(gleft.TextMatrix(i, 2))
        Else
            t1 = rat_properfractional(gleft.TextMatrix(i, 2))
            If rat1_gret_rat2(t1, max_frac) Then
                krow = i
                max_frac = t1
            End If
        End If
    End If
End If
Next i

t2 = ">=" & max_frac
addcon = "ADDED CONSTRAINT:" & vbCrLf & vbCrLf

If Not frac_x Then
MsgBox "YOU ALREADY GOT AN MIXED-INTEGER FEASIBLE SOLUTION." & vbCrLf & "ALL SPECIFIED VARIABLES ARE INTEGERS."
mixed_method_sub = True
Exit Function
End If

t1 = ratdiv(max_frac, ratsub(max_frac, "1"))

tmp = give_gomerian_slack(gup)
gup.cols = gup.cols + 1
gleft.rows = gleft.rows + 1
If .TextMatrix(0, .cols - 1) = "RATIO" Then
    .rows = .rows + 4
    .TextMatrix(0, .cols - 1) = ""
    gmid.TextMatrix(.rows - 4, 0) = "RATIO"
    gmid.TextMatrix(.rows - 3, 0) = "(M)"
    gmid.TextMatrix(.rows - 2, 0) = "(NON-M)"

Else
    .rows = .rows + 1
    .cols = .cols + 1
End If

gleft.TextMatrix(gleft.rows - 1, 0) = "0"
gleft.TextMatrix(gleft.rows - 1, 1) = tmp
gleft.TextMatrix(gleft.rows - 1, 2) = ratmul("-1", max_frac)

gup.TextMatrix(0, gup.cols - 1) = "0"
gup.TextMatrix(1, gup.cols - 1) = tmp
.TextMatrix(0, .cols - 1) = tmp


For i = 1 To gleft.rows - 2 Step 1
    .TextMatrix(i, .cols - 1) = "0"
Next i

i = .rows - 1
While i >= gleft.rows
    For j = 0 To .cols - 1 Step 1
        .TextMatrix(i, j) = .TextMatrix(i - 1, j)
        .TextMatrix(i - 1, j) = ""
    Next j
i = i - 1
Wend

.TextMatrix(gleft.rows - 1, .cols - 1) = "1"

max_frac = t1
frac_x = False
For j = 1 To .cols - 2 Step 1
    t1 = .TextMatrix(krow, j)
    If Not rat_rat(t1) Then
        .TextMatrix(gleft.rows - 1, j) = "0"
    Else
        If rat_less0(t1) Then
            .TextMatrix(gleft.rows - 1, j) = ratmul("-1", ratmul(max_frac, t1))
        Else
            .TextMatrix(gleft.rows - 1, j) = ratmul("-1", rat_properfractional(t1))
        End If
        tmp = ratmul(.TextMatrix(gleft.rows - 1, j), "-1")
        addcon = addcon & IIf(rat_geq0(tmp), IIf(Not frac_x, "", "+") & tmp, tmp) & "x" & .TextMatrix(0, j)
        frac_x = True
    End If
Next j

addcon = addcon & t2
If showcon Then MsgBox addcon
mixed_method_sub = False
End With
End Function

Public Function gomery_method_sub(gup As MSHFlexGrid, gmid As MSHFlexGrid, gleft As MSHFlexGrid, gsol As MSHFlexGrid, showcon As Boolean) As Boolean
Dim frac_x As Boolean
Dim max_frac As String
Dim krow As Integer
Dim i As Integer
Dim j As Integer
Dim tmp As String
Dim t1 As String
Dim addcon As String

With gmid

frac_x = False
For i = 1 To gleft.rows - 1 Step 1
If restrictedtointeger(gleft, i) Then
    If rat_rat(gleft.TextMatrix(i, 2)) Then
        If Not frac_x Then
            frac_x = True
            krow = i
            max_frac = rat_properfractional(gleft.TextMatrix(i, 2))
        Else
            t1 = rat_properfractional(gleft.TextMatrix(i, 2))
            If rat1_gret_rat2(t1, max_frac) Then
                krow = i
                max_frac = t1
            End If
        End If
    End If
End If
Next i

If Not frac_x Then
MsgBox "YOU ALREADY GOT AN INTEGER FEASIBLE SOLUTION"
gomery_method_sub = True
Exit Function
End If

addcon = "ADDED CONSTRAINT:" & vbCrLf & vbCrLf

tmp = give_gomerian_slack(gup)

gup.cols = gup.cols + 1
gleft.rows = gleft.rows + 1
If .TextMatrix(0, .cols - 1) = "RATIO" Then
    .rows = .rows + 4
    .TextMatrix(0, .cols - 1) = ""
    gmid.TextMatrix(.rows - 4, 0) = "RATIO"
    gmid.TextMatrix(.rows - 3, 0) = "(M)"
    gmid.TextMatrix(.rows - 2, 0) = "(NON-M)"

Else
    .rows = .rows + 1
    .cols = .cols + 1
End If

gleft.TextMatrix(gleft.rows - 1, 0) = "0"
gleft.TextMatrix(gleft.rows - 1, 1) = tmp
gleft.TextMatrix(gleft.rows - 1, 2) = ratmul("-1", max_frac)

gup.TextMatrix(0, gup.cols - 1) = "0"
gup.TextMatrix(1, gup.cols - 1) = tmp
.TextMatrix(0, .cols - 1) = tmp


For i = 1 To gleft.rows - 2 Step 1
    .TextMatrix(i, .cols - 1) = "0"
Next i

i = .rows - 1
While i >= gleft.rows
    For j = 0 To .cols - 1 Step 1
        .TextMatrix(i, j) = .TextMatrix(i - 1, j)
        .TextMatrix(i - 1, j) = ""
    Next j
i = i - 1
Wend

.TextMatrix(gleft.rows - 1, .cols - 1) = "1"

frac_x = False
For j = 1 To .cols - 2 Step 1
    t1 = .TextMatrix(krow, j)
    If Not rat_rat(t1) Then
        .TextMatrix(gleft.rows - 1, j) = "0"
    Else
        .TextMatrix(gleft.rows - 1, j) = ratmul("-1", rat_properfractional(t1))
        tmp = ratmul(.TextMatrix(gleft.rows - 1, j), "-1")
        addcon = addcon & IIf(rat_geq0(tmp), IIf(Not frac_x, "", "+") & tmp, tmp) & "x" & .TextMatrix(0, j)
        frac_x = True
    End If
Next j

addcon = addcon & ">=" & max_frac

If showcon Then MsgBox addcon

gomery_method_sub = False
End With
End Function

Public Sub pure_gomery_method(mixed As Boolean, gup As MSHFlexGrid, gmid As MSHFlexGrid, gleft As MSHFlexGrid, gsol As MSHFlexGrid, gomery_opt As Integer, vars As Integer, cons As Integer, lpp_max As Boolean, lpp_matrix() As Double, lpp_rows As Long, lpp_cols As Long, lpp_obj() As Double, lpp_penalty() As Boolean, lpp_base() As Double, lpp_bases As Long, tots As Long, fprev As Long, Optional pid As Long)
Dim opt As Integer
Dim piv As pivot
Dim succ_flg As Boolean

If gomery_opt < 0 Or gomery_opt > 2 Then
    If Not IsMissing(pid) Then
        Call simplex_make_matrix(pid, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
        gmid.clear
        gup.clear
        gleft.clear
        Call simplex_load_tables(gup, gmid, gleft, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
        fprev = 0
    End If
    gomery_opt = 0
End If

If gomery_opt = 0 Then
    piv = simplex_reload_tables(gup, gmid, gleft, gsol, vars, lpp_max, opt)
    fprev = fprev + 1
    If opt = 0 Then
        gomery_opt = 1
    Else
        If opt = 1 Then
            MsgBox "SIMPLEX METHOD FAILED,TERMINATING"
            gomery_opt = 3
            Exit Sub
        Else
           fprev = fprev + 1
           Call simplex_reduce_tounity(gleft, gmid, gup, piv)
        End If
    End If
Else
    If gomery_opt = 1 Then
        fprev = fprev + 1
        If Not mixed Then
            succ_flg = gomery_method_sub(gup, gmid, gleft, gsol, False)
        Else
            succ_flg = mixed_method_sub(gup, gmid, gleft, gsol, False)
        End If
            
        If succ_flg Then
            gomery_opt = 4
            Exit Sub
        Else
            gomery_opt = 2
        End If
        
    Else
        If gomery_opt = 2 Then
            piv = dualsimplex_reload_tables(gup, gmid, gleft, gsol, vars, lpp_max, opt)
            fprev = fprev + 1
            If opt = 0 Then
                gomery_opt = 1
            Else
                If opt = 1 Then
                    MsgBox "DUALSIMPLEX METHOD FAILED,TERMINATING"
                    gomery_opt = 3
                    Exit Sub
                Else
                    fprev = fprev + 1
                    Call dualsimplex_reduce_tounity(gleft, gmid, gup, piv)
                End If
            End If
        End If
    End If
End If
End Sub

Public Function give_gomerian_slack(gup As MSHFlexGrid) As String
Dim j As Integer
Dim cnt As Integer

cnt = 0
For j = 1 To gup.cols - 1 Step 1
    If Trim(Mid(gup.TextMatrix(1, j), 1, 1)) = "G" Then
        cnt = cnt + 1
    End If
Next j

give_gomerian_slack = "G" & Trim(str(cnt + 1))

End Function


Public Function restrictedtointeger(gleft As MSHFlexGrid, indx As Integer) As Boolean
Dim flg As Boolean
Dim var_indx As Integer

If Trim(left(Trim(gleft.TextMatrix(indx, 1)), 1)) <> "Y" Then
      restrictedtointeger = False
      Exit Function
End If

var_indx = Val(Trim(right(Trim(gleft.TextMatrix(indx, 1)), Len(Trim(gleft.TextMatrix(indx, 1))) - 1)))

If var_indx > lpp_varint.vars Or var_indx = 0 Then
    flg = False
Else
    If lpp_varint.isint(var_indx) = True Then
        flg = True
    Else
        flg = False
    End If
End If

restrictedtointeger = flg

End Function

Private Function val_in_gleft(gleft As MSHFlexGrid, var As Integer) As String
Dim i As Integer

For i = 1 To gleft.rows - 1 Step 1
    If Trim(gleft.TextMatrix(i, 1)) = Trim("Y" & Trim(str(var))) Then
        val_in_gleft = gleft.TextMatrix(i, 2)
        Exit Function
    End If
Next i
val_in_gleft = "0"
End Function


Public Function proper_fraction(x As Double) As Double
Dim tmp As String
Dim dot_indx As Integer
Dim m As Long
Dim n As Double
Dim i As Integer

tmp = Trim(str(x))
dot_indx = -1
For i = 1 To Len(tmp) Step 1
    If Mid(tmp, i, 1) = "." Then
        dot_indx = i
        Exit For
    End If
Next i

If dot_indx = -1 Then
    proper_fraction = 0
    Exit Function
End If

m = Val(Mid(tmp, 1, dot_indx - 1))

If x >= 0 Then
    n = Val(Mid(tmp, dot_indx, Len(tmp) - dot_indx + 1))
Else
    m = -m
    m = m + 1
    n = Round(m + x, 8)
End If

proper_fraction = n

End Function

Private Function all_subs_completed(s() As subprblm, indx As Integer, pbar As ProgressBar) As Boolean
Dim i As Integer

For i = 0 To indx Step 1
    If s(i).state = 0 Then
        all_subs_completed = False
        Exit Function
    End If
Next i
pbar.Value = pbar.max
Call Sleep(10)
all_subs_completed = True
End Function

Public Function generate_subprblms(s() As subprblm, d() As subdetails, indx As Integer, pbar As ProgressBar) As Boolean
Dim frm As New lpp_bbm
Dim cnt As Integer
Dim i As Integer
Dim j As Integer
Dim flg As Boolean
Dim max_frac As String
Dim tmp As String
Dim tmp1 As Integer
Dim col As Integer
Dim id1 As Integer
Dim id2 As Integer

frm.Visible = False

With frm.gresult
i = 0
cnt = 1
pbar.Value = 5
While Not all_subs_completed(s, indx, pbar)
    If s(i).state = 0 Then
        frm.type_solve = "BBM"
        frm.pid = s(i).id
        flg = frm.lppform_bbm_solver
        If Not flg Then
            s(i).state = 3
        Else
            flg = True
            ReDim d(i).x(.cols - 2) As String
            For j = 1 To .cols - 2
                d(i).x(j - 1) = .TextMatrix(1, j)
                tmp = rat_properfractional(.TextMatrix(1, j))
                If rat_rat(.TextMatrix(1, j)) Then
                    If flg Then
                        flg = False
                        max_frac = tmp
                        col = j
                    Else
                        If rat1_gret_rat2(tmp, max_frac) Then
                            flg = False
                            max_frac = tmp
                            col = j
                        End If
                    End If
                End If
            Next j
            d(i).x(.cols - 2) = .TextMatrix(1, .cols - 1)
            tmp1 = Int(rat_real(.TextMatrix(1, col)))
            If Not flg Then
                
                If indx > cnt * 10 Then
                    If MsgBox("AROUND " & str(indx) & " SUB PROBLEMS ARE GENERATED." _
                    & vbCrLf & "SOME OF THEM STILL CONTAINS NON INTEGER SOLUTIONS." _
                    & vbCrLf & "SO MORE SUB PROBLEMS WILL BE CREATED." _
                    & vbCrLf & "ARE YOU SURE TO CONTINUE?", vbYesNo, "CONFIRM!!!") = vbNo Then
                    
                        generate_subprblms = False
                        Exit Function
                    Else
                        cnt = cnt + 1
                    End If
                    pbar.Value = 10
                End If
                id1 = savesubprblm(s(i).id, col, CDec(tmp1), "LE")
                id2 = savesubprblm(s(i).id, col, CDec(tmp1 + 1), "GE")
                ReDim Preserve s(indx + 2) As subprblm
                ReDim Preserve d(indx + 2) As subdetails
                s(indx + 1).id = id1
                s(indx + 2).id = id2
                s(i).state = 2
                s(indx + 1).state = 0
                s(indx + 2).state = 0
                s(indx + 1).subcnt = s(i).subcnt & ".1"
                s(indx + 2).subcnt = s(i).subcnt & ".2"
                
                Load mdi.subprblms.item(indx + 1)
                mdi.subprblms(indx + 1).Caption = Trim(str(indx + 1)) & ".Sub Problem:" & s(indx + 1).subcnt _
                & "(Added Constraint:" & "X" & Trim(str(col)) & "<=" & Trim(str(tmp1)) & ")"
                mdi.subprblms(indx + 1).Visible = True
                Load mdi.subprblms.item(indx + 2)
                mdi.subprblms(indx + 2).Caption = Trim(str(indx + 2)) & ".Sub Problem:" & s(indx + 2).subcnt _
                & "(Added Constraint:" & "X" & Trim(str(col)) & ">=" & Trim(str(tmp1 + 1)) & ")"
                mdi.subprblms(indx + 2).Visible = True
                indx = indx + 2
            Else
                s(i).state = 1
                If pbar.Value < pbar.max Then pbar.Value = pbar.Value + 5
            End If
        
        End If
    End If
    i = i + 1
    If i > indx Then i = 0

Wend
Unload frm
generate_subprblms = True
End With
End Function

Private Function savesubprblm(id As Long, varindx As Integer, varvalue As Double, e_type As String) As Integer
Dim Y As New Recordset
Dim nid As Integer
Dim n As Integer
Dim m As Integer
Dim i As Integer

Call connect
nid = getmaxid("pid", "lpp_main", 0, False)
Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & id)
n = Y.Fields("n")
m = Y.Fields("m")
dn.cn.Execute "insert into lpp_main(pid,n,m) values(" & nid & "," & Y.Fields("n") & "," & Y.Fields("m") + 1 & ")"

Set Y = dn.cn.Execute("select o_c,e_type,coid from lpp_sub1 where pid=" & id)
Y.MoveFirst
While Not Y.EOF
dn.cn.Execute "insert into lpp_sub1(pid,o_c,e_type,coid) values(" & nid _
& ",'" & Y.Fields("o_c") & "','" & Y.Fields("e_type") & "'," & Y.Fields("coid") & ")"

Y.MoveNext
Wend

Set Y = dn.cn.Execute("select coid,v_value,v_order from lpp_sub2 where pid=" & id)
Y.MoveFirst
While Not Y.EOF
dn.cn.Execute "insert into lpp_sub2(pid,coid,v_value,v_order) values(" & nid _
& "," & Y.Fields("coid") & "," & Y.Fields("v_value") & "," & Y.Fields("v_order") & ")"

Y.MoveNext
Wend

dn.cn.Execute "insert into lpp_sub1(pid,o_c,e_type,coid) values(" & nid _
& ",'C','" & Trim(e_type) & "'," & m + 1 & ")"


For i = 1 To n Step 1
    
    If i = varindx Then
        
        dn.cn.Execute "insert into lpp_sub2(pid,coid,v_value,v_order) values(" & nid _
        & "," & m + 1 & ",1," & i & ")"
        
        dn.cn.Execute "insert into lpp_sub2(pid,coid,v_value,v_order) values(" & nid _
        & "," & m + 1 & "," & varvalue & "," & n + 1 & ")"
        
    Else
        dn.cn.Execute "insert into lpp_sub2(pid,coid,v_value,v_order) values(" & nid _
        & "," & m + 1 & ",0," & i & ")"
    End If
    
Next i

savesubprblm = nid

End Function


Public Sub create_main_tables_access()
 On Error Resume Next
 dn.cn.BeginTrans
 dn.cn.Execute "create table tpp_main(tid long, nsrc long, ndst long, t_type text(2),tora text(1),primary key(tid))"
 dn.cn.Execute "create table tpp_sub1(tid long, sdno long, recap long, sord text(1),primary key(tid,sdno,sord),foreign key(tid) references tpp_main)"
 dn.cn.Execute "create table tpp_sub2(tid long, srcid long, dstid long, cost double,primary key(tid,srcid,dstid))"
 
 dn.cn.Execute "create table lpp_main(pid long,n long,m long,primary key (pid))"
 dn.cn.Execute "create table lpp_sub1(pid long,o_c text(1),e_type text(2),coid long,primary key(pid,coid),foreign key (pid) references lpp_main)"
 dn.cn.Execute "create table lpp_sub2(pid long,coid long,v_order long,v_value double,foreign key (pid,coid) references lpp_sub1)"
 
 dn.cn.Execute "create table sp_main(sid long,ms long,js long,s_type text(2),primary key(sid))"
 dn.cn.Execute "create table sp_sub1(sid long,mac long,job long,time_dur double,e_order long,foreign key(sid) references sp_main)"
 
 dn.cn.Execute "create table matx_main(matxid long,rs long,cs long,primary key(matxid))"
 dn.cn.Execute "create table matx_sub1(matxid long,r long,c long,elmnt double,foreign key (matxid) references matx_main)"
 dn.cn.CommitTrans
End Sub

Public Sub create_main_tables_oracle()

On Error Resume Next

dn.cn.BeginTrans
dn.cn.Execute "create table lpp_main(pid number(7),n number(7),m number(7),primary key (pid))"
dn.cn.Execute "create table lpp_sub1(pid number(7),o_c char(1),e_type char(2),coid number(7),primary key(pid,coid),foreign key (pid) references lpp_main)"
dn.cn.Execute "create table lpp_sub2(pid number(7),coid number(7),v_order number(7),v_value number(16,8),foreign key (pid,coid) references lpp_sub1)"


dn.cn.Execute "create table tpp_main(tid  number(7),nsrc  number(7),ndst  number(7), t_type  varchar2(2) ,tora  varchar2(1) ,primary key(tid))"
dn.cn.Execute "create table tpp_sub1(tid  number(7), sdno  number(7), recap  number(8), sord  varchar2(1) ,primary key(tid,sdno,sord),foreign key(tid) references tpp_main)"
dn.cn.Execute "create table tpp_sub2(tid  number(7), srcid  number(7), dstid  number(7), cost  number(16,6),primary key(tid,srcid,dstid))"

dn.cn.Execute "create table sp_main(sid number(7),ms number(7),js number(7),s_type varchar2(2),primary key(sid))"
dn.cn.Execute "create table sp_sub1(sid number(7),mac number(7),job number(7),time_dur number(16,6),e_order number(7),foreign key(sid) references sp_main)"

dn.cn.Execute "create table matx_main(matxid number(7),rs number(7),cs number(7),primary key(matxid))"
dn.cn.Execute "create table matx_sub1(matxid number(7),r number(7),c number(7),elmnt number(16,8),foreign key (matxid) references matx_main)"
dn.cn.CommitTrans
End Sub

Public Sub delete_record(table_ As String, field_ As String, field_val As Long, isnumeric As Boolean, istran As Boolean)
    Call connect
    If istran Then dn.cn.BeginTrans
    dn.cn.Execute "delete from " + table_ + " where " + field_ + "=" + IIf(Not isnumeric, "'", "") + Trim(str(field_val)) + IIf(Not isnumeric, "'", "")
    If istran Then dn.cn.CommitTrans
End Sub

