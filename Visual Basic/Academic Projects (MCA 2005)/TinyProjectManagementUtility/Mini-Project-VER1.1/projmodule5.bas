Attribute VB_Name = "projmodule5"

Option Explicit

Type garnelement
    
    taskname As String
    start_offset As Long
    end_offset As Long

End Type


Type garngeneral
    taskmindate As Date
    taskmaxoffset As Long
    taskcount As Long
End Type


Type graphical_path
    taskname As String
    taskid As Long
    angle As Double
    final As Boolean
    initial As Boolean
End Type


Type struct_path
    g_path() As graphical_path
    xc As Double
    yc As Double
    r1 As Long
    r2 As Long
    task_count As Long
End Type


Public Sub real_garnformat(rs As Recordset, tnam As String, strtdte As String, enddte As String, X As garngeneral, z() As garnelement)
On Error GoTo cancel

Dim I As Integer

X.taskcount = rs.RecordCount
X.taskmindate = max_or_min_date(rs, False, strtdte)
X.taskmaxoffset = Abs(DateDiff("d", max_or_min_date(rs, True, enddte), X.taskmindate))

ReDim z(X.taskcount) As garnelement
I = 0
rs.MoveFirst
While Not rs.EOF
    z(I).taskname = rs(tnam)
    z(I).start_offset = Abs(DateDiff("d", DateValue(rs(strtdte)), _
               X.taskmindate))
    
    z(I).end_offset = Abs(DateDiff("d", DateValue(rs(enddte)), X.taskmindate))
    
    I = I + 1
    rs.MoveNext
Wend

Exit Sub
cancel:
    MsgBox Err.Description
End Sub

Public Sub earlyorlate_garnformat(rs As Recordset, tnam As String, early_late As String, tdur As String, X As garngeneral, z() As garnelement)
On Error GoTo cancel

Dim I As Integer

X.taskcount = rs.RecordCount
X.taskmindate = max_or_min_date(rs, False, early_late)
X.taskmaxoffset = Abs(DateDiff("d", max_or_min_dateafteradd(rs, True, early_late, tdur), X.taskmindate))

ReDim z(X.taskcount) As garnelement
I = 0
rs.MoveFirst
While Not rs.EOF
    z(I).taskname = rs(tnam)
    z(I).start_offset = Abs(DateDiff("d", DateValue(rs(early_late)), _
               X.taskmindate))
    
    z(I).end_offset = Abs(DateDiff("d", DateAdd("d", rs(tdur), DateValue(rs(early_late))), X.taskmindate))
    
    I = I + 1
    rs.MoveNext
Wend

Exit Sub
cancel:
    MsgBox Err.Description
End Sub

Public Sub draw_garn_chart(pic As PictureBox, X As garngeneral, Y() As garnelement)
On Error GoTo cancel


Dim yinc As Double
Dim yaxis As Double
Dim x1, x2 As Double
Dim I As Integer
Dim l, m, n, tmp As Integer

l = 255
m = 0
n = 0

pic.Line Step(0, 0)-Step(0, pic.Height)
pic.Line Step(pic.Width, pic.Height)-Step(0, pic.Height)

yinc = pic.Height / (X.taskcount + 1)
yaxis = yinc
I = 0
While I < X.taskcount
    x1 = (Y(I).start_offset / X.taskmaxoffset) * (pic.Width - 100)
    x2 = (Y(I).end_offset / X.taskmaxoffset) * (pic.Width - 100)
    pic.Line (x1, yaxis - (yinc / 10))-(x2, yaxis + (yinc / 10)), RGB(l, m, n), BF
       
    tmp = n
    n = m
    m = l
    l = tmp
    
    pic.FontBold = False
    pic.FontItalic = False
    pic.FontSize = 8
    pic.FontName = "arial narrow"
    
    pic.CurrentX = x1
    pic.CurrentY = (yaxis - (yinc / 10)) - 14
    pic.Print Format$(DateAdd("d", Y(I).start_offset, X.taskmindate), "dd-mmm-yyyy")
   
    pic.CurrentX = x2 + 2
    pic.CurrentY = yaxis - 8
    pic.Print Format$(DateAdd("d", Y(I).end_offset, X.taskmindate), "dd-mmm-yyyy") & "  (" & Trim(Y(I).taskname) & ")"
    
    yaxis = yaxis + yinc
    I = I + 1
Wend

x2 = 0
While x2 <= X.taskmaxoffset
    x1 = (x2 / X.taskmaxoffset) * (pic.Width - 100)
    pic.Line (x1, pic.Height - 8)-(x1, pic.Height), RGB(800, 0, 0)
    pic.CurrentY = pic.Height - 20
    pic.CurrentX = x1
    pic.Print Format$(DateAdd("d", x2, X.taskmindate), "dd/mm/yy")
    x2 = x2 + (X.taskmaxoffset / 5)
Wend

Exit Sub

cancel:
    MsgBox Err.Description
    

End Sub

Private Function point_between(xi As Double, yi As Double, x1 As Double, y1 As Double, x2 As Double, y2 As Double) As Boolean
Dim f1 As Boolean
Dim f2 As Boolean

    If x1 <= x2 Then
        f1 = IIf(Round(xi, 4) >= Round(x1, 4) And Round(xi, 4) <= Round(x2, 4), True, False)
    Else
        f1 = IIf(Round(xi, 4) <= Round(x1, 4) And Round(xi, 4) >= Round(x2, 4), True, False)
    End If
    If y1 <= y2 Then
        f2 = IIf(Round(yi, 4) >= Round(y1, 4) And Round(yi, 4) <= Round(y2, 4), True, False)
    Else
        f2 = IIf(Round(yi, 4) <= Round(y1, 4) And Round(yi, 4) >= Round(y2, 4), True, False)
    End If

    If Not f1 Or Not f2 Then
        point_between = False
    Else
        point_between = True
    End If

End Function


Private Sub draw_arrow(pic As PictureBox, pth As struct_path, indx_s As Integer, indx_e As Integer)
Dim rad As Double
Dim m As Double
Dim C As Double
Dim x1 As Double
Dim y1 As Double
Dim x2 As Double
Dim y2 As Double
Dim xmid As Double
Dim ymid As Double
Dim t1 As Double
Dim t2 As Double
Dim t3 As Double
Dim flg As Integer

    rad = ((22# / 7#) / 180#)

    With pth
                  
        flg = IIf(.g_path(indx_s).angle <= .g_path(indx_e).angle, 1, -1)
        t1 = .g_path(indx_s).angle
        t2 = .g_path(indx_e).angle
        
        flg = flg * IIf((t1 >= 0 And t1 <= 45 And t2 >= 315 And t2 <= 360) _
                      Or (t2 >= 0 And t2 <= 45 And t1 >= 315 And t1 <= 360) _
                      , -1, 1)
            
        xmid = .r1 * (Cos(.g_path(indx_s).angle * rad) + Cos(.g_path(indx_e).angle * rad)) / 2
        ymid = .r2 * (Sin(.g_path(indx_s).angle * rad) + Sin(.g_path(indx_e).angle * rad)) / 2
        
        x1 = .r1 * Cos((.g_path(indx_e).angle + flg * 45#) * rad)
        y1 = .r2 * Sin((.g_path(indx_e).angle + flg * 45#) * rad)
        m = (y1 - ymid) / (x1 - xmid)
        C = (x1 * ymid - xmid * y1) / (x1 - xmid)
        t3 = .r1 * .r1 * m * m + .r2 * .r2
        t2 = .r1 * .r2 * Sqr(t3 - C * C)
        t1 = -.r1 * .r1 * m * C
        x2 = (t1 + t2) / t3
        y2 = m * x2 + C
        If Round(x2, 4) = Round(x1, 4) And Round(y2, 4) = Round(y1, 4) Then
            x2 = (t1 - t2) / t3
            y2 = m * x2 + C
        End If
        x1 = x2
        y1 = y2
        
        t1 = 15
        t2 = 1
        Do While t2 <= 2
                x2 = t1 / Sqr(1# + m * m) + xmid
                y2 = m * x2 + C
                
                If Not point_between(x2, y2, xmid, ymid, x1, y1) Then
                        x2 = -t1# / Sqr(1# + m * m) + xmid
                        y2 = m * x2 + C
                        If Not point_between(x2, y2, xmid, ymid, x1, y1) Then
                                If Not point_between(x1, y1, xmid, ymid, x2, y2) Then
                                        x2 = t1# / Sqr(1# + m * m) + xmid
                                        y2 = m * x2 + C
                                End If
                        End If
                End If
                
                pic.Line (xmid + .xc, ymid + .yc)-(x2 + .xc, y2 + .yc)
                
                If t2 = 1 Then
                        x1 = .r1 * Cos((.g_path(indx_s).angle - flg * 45) * rad)
                        y1 = .r2 * Sin((.g_path(indx_s).angle - flg * 45) * rad)
                        m = (y1 - ymid) / (x1 - xmid)
                        C = (x1 * ymid - xmid * y1) / (x1 - xmid)
                End If
                
                t2 = t2 + 1
        Loop
 
    End With
End Sub


Public Sub draw_path(pic As PictureBox, pth As struct_path, is_crit As Boolean)
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
Dim xi As Double
Dim yi As Double
Dim rad As Double
Dim I As Integer
Dim j As Integer
Dim k As Integer
Dim l As Integer

pic.ForeColor = RGB(0, 0, 0)
pic.FontName = "courier new"
pic.FontUnderline = False
pic.FontBold = False
pic.CurrentX = 5
pic.CurrentY = 5
pic.Print "RED text:final task, " & "GREEN text:initial task, " & "BLUE text:both."

If is_crit Then
        Call find_critical_paths(glob_proj.pid)
        pic.CurrentX = 5
        pic.CurrentY = pic.Height - 20
        pic.Print "critical path length " & Trim(Str(glob_proj.pdur)) & " days."
End If

rad = ((22# / 7#) / 180#)

pth.xc = pic.Width / 2#
pth.yc = pic.Height / 2#
pth.r1 = Abs(Abs(pic.Width / 2#) - 9 * findmaxlen(pth)) - 5
pth.r2 = Abs(Abs(pic.Height / 2#) - 16) - 8
With pth
For I = 0 To pth.task_count - 1 Step 1
    xi = .xc + .r1 * Cos(.g_path(I).angle * rad)
    yi = .yc + .r2 * Sin(.g_path(I).angle * rad)
    pic.FontName = "courier new"
    pic.FontSize = 8

    pic.Circle (xi, yi), 5, RGB(350, 50, 270)
    pic.Circle (xi, yi), 4, RGB(350, 50, 270)
    pic.Circle (xi, yi), 3, RGB(350, 50, 270)
    pic.Circle (xi, yi), 2, RGB(350, 50, 270)
    pic.Circle (xi, yi), 1, RGB(350, 50, 270)
    
    If Not .g_path(I).final And Not .g_path(I).initial Then
        pic.FontBold = False
        pic.FontUnderline = False
        pic.ForeColor = RGB(0, 0, 0)
    Else
        pic.FontBold = True
        pic.FontUnderline = True
        If .g_path(I).final And .g_path(I).initial Then
             pic.ForeColor = RGB(0, 0, 300)
        Else
            If Not .g_path(I).final And .g_path(I).initial Then
                pic.ForeColor = RGB(0, 300, 0)
            Else
                pic.ForeColor = RGB(300, 0, 0)
            End If
        End If
    End If
    
    If (.g_path(I).angle >= 0 And .g_path(I).angle <= 90) Or (.g_path(I).angle >= 270 And .g_path(I).angle <= 360) Then
        pic.CurrentX = xi
        pic.CurrentY = yi + 5
    Else
        pic.CurrentX = xi - Len(.g_path(I).taskname) * 8 - 5
        pic.CurrentY = yi
    End If

    pic.Print .g_path(I).taskname
Next I

Set X = dn.cn
If X.State = adStateClosed Then X.Open

If Not is_crit Then
        pic.ForeColor = RGB(0, 0, 0)
        I = 0
        While I < .task_count
            Set Y = X.Execute("select distinct(taskrelated) as trel from successortasks where(projid=" & _
                        glob_proj.pid & " and taskid=" & .g_path(I).taskid & " and taskrelated is not null)")
            
            If Not Y.BOF And Not Y.EOF Then Y.MoveFirst
            While Not Y.EOF
                j = indexin_structpath(pth, Val(Y("trel")))
                If j <> -1 Then
                    
                    pic.Line (.xc + .r1 * Cos(.g_path(I).angle * rad), .yc + .r2 * Sin(.g_path(I).angle * rad)) _
                            -(.xc + .r1 * Cos(.g_path(j).angle * rad), .yc + .r2 * Sin(.g_path(j).angle * rad)), RGB(0, 0, 0)
                    
                    
                    Call draw_arrow(pic, pth, I, j)
                 
                 End If
            Y.MoveNext
            Wend
        I = I + 1
        Wend
Else
        I = 0
        While I <= critical_rows
            j = 0
            While j < critical_paths(I).cols
                Set Y = X.Execute("select taskid as tid from subtasks where(projid=" & glob_proj.pid & " and taskname='" & Trim(critical_paths(I).arrays(j)) & "')")
                k = indexin_structpath(pth, Val(Y("tid")))
                Set Y = X.Execute("select taskid as tid from subtasks where(projid=" & glob_proj.pid & " and taskname='" & Trim(critical_paths(I).arrays(j + 1)) & "')")
                l = indexin_structpath(pth, Val(Y("tid")))
                If k <> -1 And l <> -1 Then
                                          
                            
                pic.Line (.xc + .r1 * Cos(.g_path(k).angle * rad), .yc + .r2 * Sin(.g_path(k).angle * rad)) _
                         -(.xc + .r1 * Cos(.g_path(l).angle * rad), .yc + .r2 * Sin(.g_path(l).angle * rad)), RGB(300, 0, 0)
                    
                pic.ForeColor = RGB(300, 0, 0)
                
                Call draw_arrow(pic, pth, k, l)
                 
                End If
                j = j + 1
            Wend
            I = I + 1
        Wend
End If

End With
Exit Sub

cancel:
    MsgBox Err.Description
    
End Sub

Private Function findmaxlen(X As struct_path) As Integer
Dim I As Integer
Dim lens As Integer

If X.task_count >= 1 Then
    lens = Len(X.g_path(0).taskname)
Else
    lens = 0
End If

I = 1
While I < X.task_count
    If Len(X.g_path(I).taskname) > lens Then lens = Len(X.g_path(I).taskname)
    I = I + 1
Wend

findmaxlen = lens
End Function

Public Function indexin_structpath(X As struct_path, tid As Long) As Integer
Dim I As Integer

I = 0
While I < X.task_count
    If X.g_path(I).taskid = tid Then
        indexin_structpath = I
        Exit Function
    End If
I = I + 1
Wend

indexin_structpath = -1
End Function



Public Function tani(X As Double) As Double
Dim sum As Double
Dim flg As Double
Dim term As Double
Dim n As Integer

    '---------------------------tan-1(x)=sin-1(x/sqrt(1+x*x))---------------'
    X = (X / Sqr(1 + X * X))
    If Abs(X) > 1 Then
        MsgBox "RANGE ERROR", vbOKOnly, "CRITICAL ERROR!!!"
        Exit Function
    End If
    '-----------------Actually Calculating sin-1(x) below------------------'
    sum = X
    flg = X
    term = 1
    n = 0
    Do While n <= 10000# And Abs((term * flg) / (2 * n + 1)) >= 0.0000000001
        n = n + 1
        term = term * (2 * n - 1) / (2 * n)
        flg = flg * X * X
        sum = sum + (term * flg) / (2 * n + 1)
    Loop
    '-----------------------Loop Ends---------------------------------------'
    tani = sum
End Function
