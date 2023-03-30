Attribute VB_Name = "OTM2"

Option Explicit
  
  Type crossed
    crs() As Boolean
    m As Integer
    n As Integer
  End Type
  
  Type line
    cap() As Boolean
    req() As Boolean
    m As Integer
    n As Integer
    redo As Boolean
  End Type
  
  Public cross As crossed
  
  Type machine
    m As Long
    cap() As Boolean
  End Type

  Type job
    n As Long
    req() As Boolean
  End Type
  
  Type ap
    ismax As Boolean
    f As machine
    d As job
    table() As Double    '-----------2d array
    alloc() As Boolean   '-----------2d array
  End Type
  
Public aptab As ap
Public aptab_real As ap

Type tpivot
    i As Long
    j As Long
    xist As Boolean
End Type

Type ui_vj
    allocated As Long
    isrow As Boolean
    order As Long
End Type

Type element
    i As Long
    j As Long
End Type

Type vector
    e() As element
    len As Long
End Type

Type path
    isrow As Boolean
    endstat As Integer
    startref As Long
    reflen As Integer
    v As vector
End Type


Type sp_m2
    job() As Long
    mac1() As Double
    mac2() As Double
    isomitted() As Boolean
    jobs As Long
End Type

Type min_job
    job As Long
    isonmac1 As Boolean
    dur As Double
End Type

Type min_jobs
    m() As min_job
    issingle As Boolean
End Type

Type job_queue
    cnt As Long
    job() As Long
    pointer1 As Long
    pointer2 As Long
End Type

Type sp_m3
    jobs As Long
    mac() As Double
End Type

Type sp_mk
    jobs As Long
    macs As Long
    mac() As Double
End Type

'----------------SP:J2-----------'

Type job_prog
    low As Double
    up As Double
    process As Long
End Type

Type jobs
    cnt As Long
    curneed As Long
    jp() As job_prog
End Type

Type job_gp
    isfirst As Boolean
    j(1) As jobs
End Type

Type job_matrix
    jg() As job_gp
    cnt As Long
    optimal_schedule As Long
End Type

Type job_det
    job_mac() As Long
    job_dur() As Double
    cnt As Long
End Type

Type seq_j2
    jd(1) As job_det
End Type

Type idle
    low As Double
    high As Double
    raw_low As Double
    real_low As Double
    is_in_m1 As Boolean
End Type

Type optimal_spj2
    idle_m(1) As Double
    elapsed As Double
    idles() As idle
    idle_cnt As Long
End Type

Public spmk As sp_mk
Public spm3 As sp_m3
Public jq As job_queue
Public mj As min_jobs
Public spm2 As sp_m2

Public idles_t As optimal_spj2
Public job_mx As job_matrix
Public seqj2 As seq_j2
Public jobgp As job_gp

Private Function equal_jobprog(j1 As job_prog, j2 As job_prog) As Boolean
    If j1.low = j2.low And j1.up = j2.up And j1.process = j2.process Then
        equal_jobprog = True
    Else
        equal_jobprog = False
    End If
End Function

Private Function equal_jobs(j1 As jobs, j2 As jobs) As Boolean
Dim i As Long
If j1.cnt = j2.cnt And j1.curneed = j2.curneed Then
    i = 0
    Do While i <= j1.cnt
        If Not equal_jobprog(j1.jp(i), j2.jp(i)) Then
            equal_jobs = False
            Exit Function
        End If
    i = i + 1
    Loop
    equal_jobs = True
Else
    equal_jobs = False
End If

End Function

Private Function equal_jobgp(j1 As job_gp, j2 As job_gp) As Boolean

If j1.isfirst = j2.isfirst And equal_jobs(j1.j(0), j2.j(0)) And equal_jobs(j1.j(1), j2.j(1)) Then
    equal_jobgp = True
Else
    equal_jobgp = False
End If

End Function

Private Sub compact_jobmatx(jx As job_matrix)
Dim i As Long
Dim j As Long
Dim k As Long

i = 0
Do While i <= jx.cnt - 1
    j = i + 1
    Do While j <= jx.cnt
        If equal_jobgp(jx.jg(i), jx.jg(j)) Then
            For k = j To jx.cnt - 1 Step 1
                jx.jg(k) = jx.jg(k + 1)
            Next k
            jx.cnt = jx.cnt - 1
            ReDim Preserve jx.jg(jx.cnt) As job_gp
        Else
            j = j + 1
        End If
    Loop
    i = i + 1
Loop

End Sub


Public Sub initialize_graphic_spj2(pl As xy_plane, pic As PictureBox, sj2 As seq_j2, ids As optimal_spj2)
Dim tmp As String

pl.x_max = ids.elapsed
pl.y_max = ids.elapsed
tmp = Trim(str(Round(pl.x_max, 4)))
pl.x_centre = 7 * Len(tmp) + 50
pl.y_centre = 50
tmp = " JOB1 "
pl.x_axis_len = pic.Width - pl.x_centre - 6# * Len(tmp)
pl.y_axis_len = pic.Height - pl.y_centre - 24#
pl.xinc = pl.x_max / 10#
pl.yinc = pl.y_max / 10#
Call map_xycentreto_object(pl, pic)
End Sub

Public Sub draw_graph_spj2(pic As PictureBox, ids As optimal_spj2, jp As job_gp, pl As xy_plane, jm As job_matrix, indx As Long)
Dim i As Double
Dim j As Double
Dim k As Double
Dim tmp As String
Dim p As point
Dim p1 As point
Dim p2 As point
Dim l As Integer
Dim m As Integer
Dim n As Integer
Dim nflg As Boolean
Dim nflg1 As Boolean
    
    pic.FontItalic = False
    pic.FontBold = True
    pic.FontSize = 7
    pic.FontName = "courier new"
    
    
    p.x = 0
    p.Y = 0
    p1.x = pl.x_max
    p1.Y = 0
    
    Call provide_arrow(p1, p, 30, pic, RGB(250, 0, 0), pl, True, IIf(pl.xinc < pl.yinc, pl.xinc, pl.yinc) / 4.5)
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    pic.Line (p.x, p.Y)-(p1.x, p1.Y), RGB(200, 50, 100)
    p.x = pl.x_max
    p.Y = 1
    p = map_pointto_xyplane(p, pl)
    pic.CurrentX = p.x
    pic.CurrentY = p.Y
    pic.Print " JOB1 "
    
    p.x = 0
    p.Y = 0
    p1.x = 0
    p1.Y = pl.y_max
    Call provide_arrow(p1, p, 30, pic, RGB(250, 0, 0), pl, True, IIf(pl.xinc < pl.yinc, pl.xinc, pl.yinc) / 4.5)
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    pic.Line (p.x, p.Y)-(p1.x, p1.Y), RGB(200, 50, 100)
    
    p.x = 0
    p.Y = pl.y_max
    p = map_pointto_xyplane(p, pl)
    pic.CurrentX = p.x
    pic.CurrentY = p.Y - 10
    pic.Print "JOB2"
    
    pic.FontBold = True
    pic.FontItalic = False
    pic.FontSize = 7
    pic.FontName = "courier new"
       
i = 0
While i <= ids.elapsed
    tmp = Mid(Trim(str(i)), 1, 4)
    j = i
    p.x = j
    p.Y = -(pl.yinc / 4.5)
    p = map_pointto_xyplane(p, pl)
    pic.ForeColor = RGB(0, 0, 300)
    pic.CurrentX = p.x
    pic.CurrentY = p.Y
    pic.Print tmp
    p.x = i
    p.Y = 0
    p1.x = i
    p1.Y = -(pl.yinc / 5#)
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    p1.Y = p1.Y
    pic.Line (p.x, p.Y)-(p1.x, p1.Y), RGB(200, 0, 0)
    i = i + pl.xinc
Wend


i = pl.yinc
While i <= ids.elapsed
    tmp = Mid(Trim(str(i)), 1, 4)
    j = i
    p.x = -(pl.xinc / 3#)
    p.Y = j + pl.yinc / 4#
    p = map_pointto_xyplane(p, pl)
    pic.ForeColor = RGB(0, 0, 300)
    pic.CurrentX = p.x
    pic.CurrentY = p.Y
    pic.Print tmp
    p.x = -(pl.xinc / 5#)
    p.Y = j
    p1.x = 0
    p1.Y = j
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    p.x = p.x
    pic.Line (p.x, p.Y)-(p1.x, p1.Y), RGB(200, 0, 0)
    i = i + pl.yinc
Wend

l = 255
m = 0
n = 0

i = 0
While i <= jp.j(0).cnt
    tmp = n
    n = m
    m = l
    l = tmp
    p.x = jp.j(0).jp(i).low
    p1.x = jp.j(0).jp(i).up
    p.Y = -(pl.yinc / 1.7)
    p1.Y = -(pl.yinc / 1.7)
    Call provide_arrow(p1, p, 30, pic, RGB(l, m, n), pl, False, IIf(pl.xinc < pl.yinc, pl.xinc, pl.yinc) / 4.5)
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    p.Y = p.Y
    p1.Y = p1.Y
    pic.Line (p.x, p.Y)-(p1.x, p1.Y), RGB(l, m, n)
    p.x = (jp.j(0).jp(i).up + jp.j(0).jp(i).low) / 2#
    p.Y = -(pl.yinc / 1.5)
    p = map_pointto_xyplane(p, pl)
    pic.CurrentX = p.x
    pic.CurrentY = p.Y
    pic.Print "M" & Trim(str(jp.j(0).jp(i).process + 1))
    i = i + 1
Wend

l = 255
m = 0
n = 0

i = 0
While i <= jp.j(1).cnt
    tmp = n
    n = m
    m = l
    l = tmp
    p.Y = jp.j(1).jp(i).low
    p1.Y = jp.j(1).jp(i).up
    p.x = -(pl.xinc / 1.8)
    p1.x = -(pl.xinc / 1.8)
    Call provide_arrow(p, p1, 30, pic, RGB(l, m, n), pl, False, IIf(pl.xinc < pl.yinc, pl.xinc, pl.yinc) / 4.5)
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    p.x = p.x
    p1.x = p1.x
    pic.Line (p.x, p.Y)-(p1.x, p1.Y), RGB(l, m, n)
    p.Y = (jp.j(1).jp(i).up + jp.j(1).jp(i).low) / 2#
    p.x = -(pl.xinc / 1.3)
    p = map_pointto_xyplane(p, pl)
    pic.CurrentX = p.x
    pic.CurrentY = p.Y
    pic.Print "M" & Trim(str(jp.j(1).jp(i).process + 1))
    i = i + 1
Wend

l = 255
m = 0
n = 0

i = 0
While i <= jp.j(0).cnt
    j = counterpart_in_jobgp(jp, 0, CInt(i))
    tmp = n
    n = m
    m = l
    l = tmp
    p.x = jp.j(0).jp(i).low
    p.Y = jp.j(1).jp(j).low
    p1.x = jp.j(0).jp(i).up
    p1.Y = jp.j(1).jp(j).up
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    pic.Line (p.x, p.Y)-(p1.x, p1.Y), RGB(l, m, n), BF
    
i = i + 1
Wend

i = 0
j = 0
k = 0
While i <= ids.idle_cnt
    p.x = j
    p.Y = k
    nflg = False
    nflg1 = False
    If ids.idles(i).is_in_m1 Then
        p1.x = ids.idles(i).raw_low
        p1.Y = ids.idles(i).low
    Else
        p1.Y = ids.idles(i).raw_low
        p1.x = ids.idles(i).low
    End If
    
    If p.Y <= p1.Y Then
        If p.x <= p1.x Then
            p = map_pointto_xyplane(p, pl)
            p1 = map_pointto_xyplane(p1, pl)
            pic.Line (p1.x, p1.Y)-(p.x, p.Y), RGB(0, 0, 0)
        Else
            nflg1 = True
        End If
    Else
        nflg = True
    End If
    
    If ids.idles(i).is_in_m1 Then
        If Not nflg Then
            If Not nflg1 Then
                p.x = ids.idles(i).raw_low
                p.Y = ids.idles(i).low
                p1.x = ids.idles(i).raw_low
                p1.Y = ids.idles(i).high
            Else
                p1.x = p.x
                p1.Y = ids.idles(i).high
            End If
        Else
            p1.x = p.x
            p1.Y = ids.idles(i).high
        End If
        tmp = "J1(" & Trim(str(ids.idles(i).real_low)) & "-" & Trim(str(ids.idles(i).high)) & ")"
        p2.x = p.x
        p2.Y = (p.Y + p1.Y) / 2#
    Else
        If Not nflg Then
            If Not nflg1 Then
                p.Y = ids.idles(i).raw_low
                p.x = ids.idles(i).low
                p1.Y = ids.idles(i).raw_low
                p1.x = ids.idles(i).high
            Else
                p1.x = p.x
                p1.Y = ids.idles(i).raw_low
            End If
        Else
            p1.Y = p.Y
            p1.x = ids.idles(i).high
        End If
        tmp = "J2(" & Trim(str(ids.idles(i).real_low)) & "-" & Trim(str(ids.idles(i).high)) & ")"
        p2.x = (p1.x + p.x) / 2#
        p2.Y = p.Y
    End If
    j = p1.x
    k = p1.Y
    p = map_pointto_xyplane(p, pl)
    p1 = map_pointto_xyplane(p1, pl)
    p2 = map_pointto_xyplane(p2, pl)
    pic.Line (p1.x, p1.Y)-(p.x, p.Y), RGB(0, 0, 0)
    pic.CurrentX = p2.x
    pic.CurrentY = p2.Y
    pic.ForeColor = RGB(0, 0, 0)
    pic.FontBold = True
    pic.Print tmp
    i = i + 1
Wend
    
If Not nflg Then
    p.x = j
    p.Y = k
    p1.x = jm.jg(indx).j(0).jp(jm.jg(indx).j(0).cnt).up
    p1.Y = jm.jg(indx).j(1).jp(jm.jg(indx).j(1).cnt).up
    p1 = map_pointto_xyplane(p1, pl)
    p = map_pointto_xyplane(p, pl)
    pic.Line (p1.x, p1.Y)-(p.x, p.Y), RGB(0, 0, 0)
End If

End Sub


Public Function counterpart_in_jobgp(jp As job_gp, k As Long, indx As Long) As Long
Dim i As Long
Dim mac_need As Long

mac_need = jp.j(k).jp(indx).process
k = Abs(k - 1)
For i = 0 To jp.j(k).cnt Step 1
    If jp.j(k).jp(i).process = mac_need Then
         counterpart_in_jobgp = i
         Exit Function
    End If
Next i
counterpart_in_jobgp = -1
End Function

Public Sub create_raw_schedule(j2 As seq_j2, jobgp As job_gp)
Dim i As Long
Dim k As Long
Dim low As Double
Dim high As Double

For k = 0 To 1 Step 1
    jobgp.j(k).cnt = -1
    low = 0
    high = 0
    For i = 0 To j2.jd(k).cnt Step 1
        jobgp.j(k).cnt = jobgp.j(k).cnt + 1
        ReDim Preserve jobgp.j(k).jp(jobgp.j(k).cnt) As job_prog
        low = high
        high = low + j2.jd(k).job_dur(i)
        jobgp.j(k).jp(jobgp.j(k).cnt).process = j2.jd(k).job_mac(i)
        jobgp.j(k).jp(jobgp.j(k).cnt).low = low
        jobgp.j(k).jp(jobgp.j(k).cnt).up = high
    Next i
Next k

End Sub



Public Function give_raw_low(gp As job_gp, k As Long, mac As Long) As Double
Dim i As Integer

For i = 0 To gp.j(k).cnt Step 1
    If gp.j(k).jp(i).process = mac Then
          give_raw_low = gp.j(k).jp(i).low
          Exit Function
    End If
Next i

give_raw_low = 0

End Function

Public Function create_idles(jm As job_matrix, Index As Long, ids As optimal_spj2, seqj2 As seq_j2)
Dim i As Long
Dim k As Long
Dim jp As job_gp

Call create_raw_schedule(seqj2, jp)
ids.idle_cnt = -1
For k = 0 To 1 Step 1
    ids.idle_m(k) = 0
    For i = 0 To jm.jg(Index).j(k).cnt Step 1
        If jm.jg(Index).j(k).jp(i).process = -1 Then
            ids.idle_cnt = ids.idle_cnt + 1
            ReDim Preserve ids.idles(ids.idle_cnt) As idle
            ids.idles(ids.idle_cnt).raw_low = give_raw_low(jp, k, jm.jg(Index).j(k).jp(i + 1).process)
            ids.idles(ids.idle_cnt).low = jm.jg(Index).j(k).jp(i).low
            ids.idles(ids.idle_cnt).high = jm.jg(Index).j(k).jp(i).up
            ids.idles(ids.idle_cnt).real_low = ids.idles(ids.idle_cnt).low
            ids.idles(ids.idle_cnt).is_in_m1 = IIf(k = 0, True, False)
            ids.idle_m(k) = ids.idle_m(k) + (ids.idles(ids.idle_cnt).high - ids.idles(ids.idle_cnt).low)
        End If
    Next i
Next k

If jm.jg(Index).j(0).jp(jm.jg(Index).j(0).cnt).up > jm.jg(Index).j(1).jp(jm.jg(Index).j(1).cnt).up Then
    ids.elapsed = jm.jg(Index).j(0).jp(jm.jg(Index).j(0).cnt).up
    ids.idle_cnt = ids.idle_cnt + 1
    ReDim Preserve ids.idles(ids.idle_cnt) As idle
    
    ids.idles(ids.idle_cnt).low = jm.jg(Index).j(1).jp(jm.jg(Index).j(1).cnt).up
    ids.idles(ids.idle_cnt).real_low = ids.idles(ids.idle_cnt).low
    ids.idles(ids.idle_cnt).high = jm.jg(Index).j(0).jp(jm.jg(Index).j(0).cnt).up
    ids.idle_m(1) = ids.idle_m(1) + (ids.idles(ids.idle_cnt).high - ids.idles(ids.idle_cnt).low)
    ids.idles(ids.idle_cnt).is_in_m1 = False
    ids.idles(ids.idle_cnt).raw_low = ids.idles(ids.idle_cnt).low
    ids.idles(ids.idle_cnt).low = give_raw_low(jp, 0, jm.jg(Index).j(0).jp(jm.jg(Index).j(0).cnt).process)
Else
    ids.elapsed = jm.jg(Index).j(1).jp(jm.jg(Index).j(1).cnt).up
    If jm.jg(Index).j(0).jp(jm.jg(Index).j(0).cnt).up <> jm.jg(Index).j(1).jp(jm.jg(Index).j(1).cnt).up Then
        ids.idle_cnt = ids.idle_cnt + 1
        ReDim Preserve ids.idles(ids.idle_cnt) As idle
        
        ids.idles(ids.idle_cnt).low = jm.jg(Index).j(0).jp(jm.jg(Index).j(0).cnt).up
        ids.idles(ids.idle_cnt).real_low = ids.idles(ids.idle_cnt).low
        ids.idles(ids.idle_cnt).high = jm.jg(Index).j(1).jp(jm.jg(Index).j(1).cnt).up
        ids.idle_m(0) = ids.idle_m(0) + (ids.idles(ids.idle_cnt).high - ids.idles(ids.idle_cnt).low)
        ids.idles(ids.idle_cnt).is_in_m1 = True
        ids.idles(ids.idle_cnt).raw_low = ids.idles(ids.idle_cnt).low
        ids.idles(ids.idle_cnt).low = give_raw_low(jp, 1, jm.jg(Index).j(1).jp(jm.jg(Index).j(1).cnt).process)
    End If
End If

Call sort_idles(ids)
End Function


Public Sub sort_idles(ids As optimal_spj2)
Dim i As Long
Dim j As Long
Dim tmp As idle

For i = 0 To ids.idle_cnt - 1 Step 1
    For j = i + 1 To ids.idle_cnt Step 1
        If ids.idles(i).real_low >= ids.idles(j).real_low Then
            tmp = ids.idles(i)
            ids.idles(i) = ids.idles(j)
            ids.idles(j) = tmp
        End If
    Next j
Next i

End Sub


Public Sub create_spj2schedules(jmx As job_matrix, sj2 As seq_j2)
Dim l As job_prog
Dim tmp As job_prog
Dim i As Long
Dim k As Long
Dim j As Long
Dim isjob1 As Boolean
Dim x1 As Double
Dim dur As Double
Dim x2 As Boolean
Dim indx As Long

dur = 1

jmx.cnt = -1
Call inc_jobmatrix(jmx)
jmx.cnt = 0
ReDim jmx.jg(0) As job_gp
Call initialize_jobgp(jmx.jg(0), sj2)
i = 0
While Not all_jobs_end(jmx, sj2)
    k = IIf(jmx.jg(i).isfirst, 0, 1)
    j = 0
    While j <= 1
        If jmx.jg(i).j(k).curneed <> sj2.jd(k).cnt + 1 Then
            l = process_in_job(jmx.jg(i).j(IIf(k = 0, 1, 0)), jmx.jg(i).j(k).curneed, sj2.jd(k), indx)
            If jmx.jg(i).j(k).cnt > -1 Then
                tmp.low = jmx.jg(i).j(k).jp(jmx.jg(i).j(k).cnt).up
            Else
                tmp.low = 0
            End If
            tmp.up = tmp.low + sj2.jd(k).job_dur(jmx.jg(i).j(k).curneed)
            tmp.process = sj2.jd(k).job_mac(jmx.jg(i).j(k).curneed)
            ReDim Preserve jmx.jg(i).j(k).jp(jmx.jg(i).j(k).cnt + 1) As job_prog
            If l.low <> -1 And l.up <> -1 Then
                If Not isnotcrossed_jobprog(l, tmp) Then
                    jmx.cnt = jmx.cnt + 1
                    If jmx.cnt > dur * 75 Then
                        If MsgBox("ABOUT " & Trim(str(jmx.cnt + 1)) & " SCHEDULES ARE GENERATED, DO YOU WANT TO CONTINUE?", vbYesNo, "CONFIRM!!!") = vbNo Then
                            jmx.optimal_schedule = -1
                            Exit Sub
                        Else
                            dur = dur + 1
                        End If
                    End If
                    ReDim Preserve jmx.jg(jmx.cnt) As job_gp
                    Call copy_jobs(jmx.jg(i).j(k), jmx.jg(jmx.cnt).j(k), jmx.jg(i).j(k).cnt + 1)
                    Call copy_jobs(jmx.jg(i).j(IIf(k = 0, 1, 0)), jmx.jg(jmx.cnt).j(IIf(k = 0, 1, 0)), find_indx_in_jobdet(sj2.jd(tog(k)), tmp.process))
                    jmx.jg(jmx.cnt).j(tog(k)).curneed = find_indx_in_jobdet(sj2.jd(tog(k)), tmp.process)
                    jmx.jg(jmx.cnt).isfirst = Not jmx.jg(i).isfirst
                    jmx.jg(jmx.cnt).j(tog(k)).jp(jmx.jg(jmx.cnt).j(tog(k)).cnt).up = tmp.up
                    jmx.jg(jmx.cnt).j(tog(k)).jp(jmx.jg(jmx.cnt).j(tog(k)).cnt).process = -1
                    jmx.jg(jmx.cnt).j(k).jp(jmx.jg(jmx.cnt).j(k).cnt) = tmp
                    jmx.jg(jmx.cnt).j(k).curneed = jmx.jg(jmx.cnt).j(k).curneed + 1
                    tmp.up = l.up
                    tmp.process = -1
                    jmx.jg(i).j(k).jp(jmx.jg(i).j(k).cnt + 1) = tmp
                Else
                    tmp.process = sj2.jd(k).job_mac(jmx.jg(i).j(k).curneed)
                    jmx.jg(i).j(k).jp(jmx.jg(i).j(k).cnt + 1) = tmp
                    jmx.jg(i).j(k).curneed = jmx.jg(i).j(k).curneed + 1
                End If
            Else
                tmp.process = sj2.jd(k).job_mac(jmx.jg(i).j(k).curneed)
                jmx.jg(i).j(k).jp(jmx.jg(i).j(k).cnt + 1) = tmp
                jmx.jg(i).j(k).curneed = jmx.jg(i).j(k).curneed + 1
            End If
            jmx.jg(i).j(k).cnt = jmx.jg(i).j(k).cnt + 1
        End If
        k = IIf(k = 0, 1, 0)
        j = j + 1
    Wend
    jmx.jg(i).isfirst = True
    i = i + 1
    If i > jmx.cnt Then i = 0
Wend
           
Call compact_jobmatx(jmx)

For i = 0 To jmx.cnt Step 1
    x2 = IIf(jmx.jg(i).j(0).jp(jmx.jg(i).j(0).cnt).up > jmx.jg(i).j(1).jp(jmx.jg(i).j(1).cnt).up, True, False)
    x1 = IIf(jmx.jg(i).j(0).jp(jmx.jg(i).j(0).cnt).up > jmx.jg(i).j(1).jp(jmx.jg(i).j(1).cnt).up, jmx.jg(i).j(0).jp(jmx.jg(i).j(0).cnt).up, jmx.jg(i).j(1).jp(jmx.jg(i).j(1).cnt).up)
    If i = 0 Then
        isjob1 = x2
        dur = x1
        jmx.optimal_schedule = 0
    Else
        If dur > x1 Then
            isjob1 = x2
            dur = x1
            jmx.optimal_schedule = i
        End If
    End If
Next i


End Sub

Private Function tog(bit As Long) As Long
    tog = (bit + 1) Mod 2
End Function

Public Sub load_spj2(sid As Long, s As seq_j2)
Dim Y As New Recordset
Dim i As Integer

Call connect
Set Y = dn.cn.Execute("select ms from sp_main where sid=" & sid)
s.jd(0).cnt = Y.Fields("ms") - 1
s.jd(1).cnt = Y.Fields("ms") - 1
ReDim s.jd(0).job_mac(Y.Fields("ms") - 1) As Long
ReDim s.jd(0).job_dur(Y.Fields("ms") - 1) As Double
ReDim s.jd(1).job_mac(Y.Fields("ms") - 1) As Long
ReDim s.jd(1).job_dur(Y.Fields("ms") - 1) As Double

Set Y = dn.cn.Execute("select mac,time_dur from sp_sub1 where(sid=" & sid & " and job=1) order by e_order")
Y.MoveFirst
i = 0
While Not Y.EOF
    s.jd(0).job_mac(i) = Y.Fields("mac") - 1
    s.jd(0).job_dur(i) = Y.Fields("time_dur")
    Y.MoveNext
    i = i + 1
Wend
    
Set Y = dn.cn.Execute("select mac,time_dur from sp_sub1 where(sid=" & sid & " and job=2) order by e_order")
Y.MoveFirst
i = 0
While Not Y.EOF
    s.jd(1).job_mac(i) = Y.Fields("mac") - 1
    s.jd(1).job_dur(i) = Y.Fields("time_dur")
    Y.MoveNext
    i = i + 1
Wend
    
End Sub


Public Function all_jobs_end(x As job_matrix, sj2 As seq_j2) As Boolean
Dim i As Integer

For i = 0 To x.cnt Step 1
    If x.jg(i).j(0).curneed <> sj2.jd(0).cnt + 1 Or x.jg(i).j(1).curneed <> sj2.jd(1).cnt + 1 Then
        all_jobs_end = False
        Exit Function
    End If
Next i

all_jobs_end = True
End Function

Public Function find_indx_in_jobdet(j As job_det, ps As Long) As Long
Dim i As Long

find_indx_in_jobdet = -1
For i = 0 To j.cnt Step 1
    If j.job_mac(i) = ps Then
        find_indx_in_jobdet = i
        Exit Function
    End If
Next i

End Function

Public Function process_in_job(j As jobs, curneed As Long, sj As job_det, indx As Long) As job_prog
Dim i As Integer
Dim r As job_prog

r.low = -1
r.up = -1
indx = -1
For i = 0 To j.cnt Step 1
    If j.jp(i).process = sj.job_mac(curneed) Then
        indx = i
        r.low = j.jp(i).low
        r.up = j.jp(i).up
        process_in_job = r
        Exit Function
    End If
Next i
process_in_job = r
End Function

Public Sub initialize_jobgp(x As job_gp, Y As seq_j2)
    x.j(0).cnt = -1
    x.j(1).cnt = -1
    x.j(0).curneed = 0
    x.j(1).curneed = 0
    x.isfirst = True
End Sub


Public Sub copy_jobs(job1 As jobs, job2 As jobs, refcnt As Long)
Dim i As Integer

If refcnt <= -1 Then
    job2.cnt = -1
    job2.curneed = job1.curneed
    Exit Sub
End If

ReDim Preserve job2.jp(refcnt) As job_prog
job2.cnt = refcnt
job2.curneed = job1.curneed
For i = 0 To refcnt Step 1
    job2.jp(i).low = job1.jp(i).low
    job2.jp(i).up = job1.jp(i).up
    job2.jp(i).process = job1.jp(i).process
Next i

End Sub

Public Function isnotcrossed_jobprog(t1 As job_prog, t2 As job_prog) As Boolean
    If t1.up <= t2.low Or t1.low >= t2.up Then
        isnotcrossed_jobprog = True
    Else
        isnotcrossed_jobprog = False
    End If
End Function

Public Function iscrossed_jobprog(t1 As job_prog, t2 As job_prog) As Boolean
Dim flg As Boolean

flg = False
flg = flg Or IIf(t1.low <= t2.low And t2.low <= t2.up And t2.up <= t1.up, True, False)
If flg Then
    iscrossed_jobprog = True
    Exit Function
End If
flg = flg Or IIf(t1.low <= t2.low And t2.low < t1.up And t1.up <= t2.up, True, False)
If flg Then
    iscrossed_jobprog = True
    Exit Function
End If
flg = flg Or IIf(t2.low <= t1.low And t1.low < t2.up And t2.up <= t1.up, True, False)
If flg Then
    iscrossed_jobprog = True
    Exit Function
End If
flg = flg Or IIf(t2.low <= t1.low And t1.low <= t1.up And t1.up <= t2.up, True, False)
iscrossed_jobprog = flg
End Function

Public Sub inc_jobmatrix(j As job_matrix)
    ReDim Preserve j.jg(j.cnt + 1) As job_gp
End Sub

Public Sub inc_job(j As jobs)
    ReDim Preserve j.jp(j.cnt + 1) As job_prog
End Sub


'----------------SP:J2 END--------'

Public Sub addto_jobqueuem2(q As job_queue, m As min_jobs)
Dim i As Integer

If m.m(0).job = -1 Then Exit Sub

For i = 0 To IIf(m.issingle, 0, 1) Step 1
    If m.m(i).isonmac1 Then
        q.pointer1 = q.pointer1 + 1
        q.job(q.pointer1) = m.m(i).job
    Else
        q.pointer2 = q.pointer2 - 1
        q.job(q.pointer2) = m.m(i).job
    End If
Next i

End Sub

Public Function find_min_spm2(s As sp_m2) As min_jobs
Dim i As Integer
Dim tmp1 As Double
Dim tmp2 As Boolean
Dim m As min_jobs

ReDim m.m(1) As min_job
m.m(0).job = -1
For i = 0 To s.jobs - 1 Step 1
    If Not s.isomitted(i) Then
        tmp1 = IIf(s.mac1(i) <= s.mac2(i), s.mac1(i), s.mac2(i))
        tmp2 = IIf(s.mac1(i) <= s.mac2(i), True, False)
        If m.m(0).job = -1 Then
            m.issingle = True
            m.m(0).job = i
            m.m(0).isonmac1 = tmp2
            m.m(0).dur = tmp1
        Else
            If m.m(0).dur > tmp1 Then
                m.issingle = True
                m.m(0).job = i
                m.m(0).isonmac1 = tmp2
                m.m(0).dur = tmp1
            Else
                If m.m(0).dur = tmp1 Then
                    If Not tmp2 And Not m.m(0).isonmac1 Then
                        If s.mac1(i) > s.mac1(m.m(0).job) Then
                            m.issingle = True
                            m.m(0).job = i
                            m.m(0).isonmac1 = tmp2
                            m.m(0).dur = tmp1
                        End If
                    Else
                        If tmp2 And m.m(0).isonmac1 Then
                            If s.mac2(i) > s.mac2(m.m(0).job) Then
                                m.issingle = True
                                m.m(0).job = i
                                m.m(0).isonmac1 = tmp2
                                m.m(0).dur = tmp1
                            End If
                        Else
                            If (tmp2 And Not m.m(0).isonmac1) Or (Not tmp2 And m.m(0).isonmac1) Then
                                m.m(1).job = i
                                m.m(1).isonmac1 = tmp2
                                m.m(1).dur = tmp1
                                m.issingle = False
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End If
Next i
                       
If m.m(0).job <> -1 Then
    If Not m.issingle Then
        s.isomitted(m.m(1).job) = True
    End If
    s.isomitted(m.m(0).job) = True
End If

find_min_spm2 = m
End Function

Public Function min_max_spmk(s As sp_mk, indx As Long, ismin As Boolean) As Double
Dim i As Integer
Dim tmp As Double

tmp = s.mac(indx, 0)
For i = 1 To s.jobs - 1 Step 1
    If (ismin And tmp > s.mac(indx, i)) Or (Not ismin And tmp < s.mac(indx, i)) Then
        tmp = s.mac(indx, i)
    End If
Next i

min_max_spmk = tmp
End Function

Public Function min_max_spm3(s As sp_m3, indx As Long, ismin As Boolean) As Double
Dim i As Integer
Dim tmp As Double

tmp = s.mac(indx, 0)
For i = 1 To s.jobs - 1 Step 1
    If (ismin And tmp > s.mac(indx, i)) Or (Not ismin And tmp < s.mac(indx, i)) Then
        tmp = s.mac(indx, i)
    End If
Next i

min_max_spm3 = tmp
End Function

Public Function initialize_spmk(sid As Long, x As MSHFlexGrid, s As sp_mk, s1 As sp_m2, j As job_queue) As Boolean
Dim Y As New Recordset
Dim min_max() As Double
Dim i As Long
Dim k As Long
Dim flg1 As Boolean
Dim flgk As Boolean

Call connect
Set Y = dn.cn.Execute("select ms,js from sp_main where sid=" & sid & "")
x.rows = Y.Fields("ms") + 1
x.cols = Y.Fields("js") + 1
x.FixedCols = 1
x.FixedRows = 1
For i = 1 To x.cols - 1 Step 1
    x.TextMatrix(0, i) = "Job-" & Trim(str(i))
Next i
For i = 1 To x.rows - 1 Step 1
    x.TextMatrix(i, 0) = "Mac-" & Trim(str(i))
Next i

s.jobs = Y.Fields("js") - 1
s.macs = Y.Fields("ms") - 1
ReDim s.mac(s.macs, s.jobs) As Double

Set Y = dn.cn.Execute("select mac,job,time_dur from sp_sub1 where sid=" & sid & " order by mac,job")
Y.MoveFirst
While Not Y.EOF
    s.mac(Y.Fields("mac") - 1, Y.Fields("job") - 1) = Y.Fields("time_dur")
    x.TextMatrix(Y.Fields("mac"), Y.Fields("job")) = Y.Fields("time_dur")
    Y.MoveNext
Wend

ReDim min_max(s.macs) As Double

min_max(0) = min_max_spmk(s, 0, True)
For i = 1 To s.macs - 1 Step 1
    min_max(i) = min_max_spmk(s, i, False)
Next i
min_max(s.macs) = min_max_spmk(s, s.macs, True)


flg1 = True
flgk = True
For i = 1 To s.macs - 1 Step 1
    If min_max(0) < min_max(i) Then
        flg1 = False
    End If
    If min_max(s.macs) < min_max(i) Then
        flgk = False
    End If
    If Not flg1 And Not flgk Then
        Exit For
    End If
Next i

If Not flg1 And Not flgk Then
    initialize_spmk = False
    Exit Function
End If
    
s1.jobs = s.jobs + 1
j.cnt = s1.jobs
j.pointer1 = -1
j.pointer2 = j.cnt
ReDim j.job(j.cnt - 1) As Long
ReDim s1.isomitted(s1.jobs - 1) As Boolean
ReDim s1.job(s1.jobs - 1) As Long
ReDim s1.mac1(s1.jobs - 1) As Double
ReDim s1.mac2(s1.jobs - 1) As Double

x.rows = x.rows + 3
x.TextMatrix(x.rows - 2, 0) = "MAC-G"
x.TextMatrix(x.rows - 1, 0) = "MAC-H"

For i = 0 To s.jobs Step 1
    s1.isomitted(i) = False
    s1.job(i) = i
    s1.mac1(i) = 0
    s1.mac2(i) = 0
    For k = 0 To s.macs - 1 Step 1
        s1.mac1(i) = s1.mac1(i) + s.mac(k, i)
    Next k
    For k = 1 To s.macs Step 1
        s1.mac2(i) = s1.mac2(i) + s.mac(k, i)
    Next k
    j.job(i) = -1
    x.TextMatrix(x.rows - 2, i + 1) = s1.mac1(i)
    x.TextMatrix(x.rows - 1, i + 1) = s1.mac2(i)
Next i

initialize_spmk = True
End Function

Public Function initialize_spm3(sid As Long, x As MSHFlexGrid, s As sp_m3, s1 As sp_m2, j As job_queue) As Boolean
Dim Y As New Recordset
Dim mina As Double
Dim maxb As Double
Dim minc As Double
Dim i As Integer

Call connect
Set Y = dn.cn.Execute("select js from sp_main where sid=" & sid & "")
x.rows = 4
x.cols = Y.Fields("js") + 1
x.FixedCols = 1
x.FixedRows = 1
For i = 1 To x.cols - 1 Step 1
    x.TextMatrix(0, i) = "Job-" & Trim(str(i))
Next i
For i = 1 To x.rows - 1 Step 1
    x.TextMatrix(i, 0) = "Mac-" & Trim(str(i))
Next i

s.jobs = Y.Fields("js")
ReDim s.mac(2, s.jobs) As Double

Set Y = dn.cn.Execute("select job,time_dur from sp_sub1 where (sid=" & sid & " and mac=1) order by job")
Y.MoveFirst
While Not Y.EOF
    s.mac(0, Y.Fields("job") - 1) = Y.Fields("time_dur")
    x.TextMatrix(1, Y.Fields("job")) = Y.Fields("time_dur")
    Y.MoveNext
Wend

Set Y = dn.cn.Execute("select job,time_dur from sp_sub1 where (sid=" & sid & " and mac=2) order by job")
Y.MoveFirst
While Not Y.EOF
    s.mac(1, Y.Fields("job") - 1) = Y.Fields("time_dur")
    x.TextMatrix(2, Y.Fields("job")) = Y.Fields("time_dur")
    Y.MoveNext
Wend

Set Y = dn.cn.Execute("select job,time_dur from sp_sub1 where (sid=" & sid & " and mac=3) order by job")
Y.MoveFirst
While Not Y.EOF
    s.mac(2, Y.Fields("job") - 1) = Y.Fields("time_dur")
    x.TextMatrix(3, Y.Fields("job")) = Y.Fields("time_dur")
    Y.MoveNext
Wend

mina = min_max_spm3(s, 0, True)
maxb = min_max_spm3(s, 1, False)
minc = min_max_spm3(s, 2, True)

If Not (mina >= maxb Or minc >= maxb) Then
    initialize_spm3 = False
    Exit Function
End If


s1.jobs = s.jobs
j.cnt = s1.jobs
j.pointer1 = -1
j.pointer2 = j.cnt
ReDim j.job(j.cnt - 1) As Long
ReDim s1.isomitted(s1.jobs - 1) As Boolean
ReDim s1.job(s1.jobs - 1) As Long
ReDim s1.mac1(s1.jobs - 1) As Double
ReDim s1.mac2(s1.jobs - 1) As Double

x.rows = x.rows + 3
x.TextMatrix(x.rows - 2, 0) = "MAC-G"
x.TextMatrix(x.rows - 1, 0) = "MAC-H"

For i = 0 To s.jobs - 1 Step 1
    s1.isomitted(i) = False
    s1.job(i) = i
    s1.mac1(i) = s.mac(0, i) + s.mac(1, i)
    s1.mac2(i) = s.mac(1, i) + s.mac(2, i)
    j.job(i) = -1
    x.TextMatrix(x.rows - 2, i + 1) = s1.mac1(i)
    x.TextMatrix(x.rows - 1, i + 1) = s1.mac2(i)
Next i

initialize_spm3 = True
End Function

Public Function initialize_spm2(sid As Long, x As MSHFlexGrid, s As sp_m2, j As job_queue) As Boolean
Dim Y As New Recordset
Dim i As Integer

        Call connect
        Set Y = dn.cn.Execute("select js from sp_main where sid=" & sid & "")
        x.rows = 3
        x.cols = Y.Fields("js") + 1
        x.FixedCols = 1
        x.FixedRows = 1
        For i = 1 To x.cols - 1 Step 1
            x.TextMatrix(0, i) = "Job-" & Trim(str(i))
        Next i
        For i = 1 To x.rows - 1 Step 1
            x.TextMatrix(i, 0) = "Mac-" & Trim(str(i))
        Next i
        s.jobs = Y.Fields("js")
        j.cnt = Y.Fields("js")
        j.pointer1 = -1
        j.pointer2 = j.cnt
        ReDim j.job(j.cnt - 1) As Long
        ReDim s.isomitted(s.jobs - 1) As Boolean
        ReDim s.job(s.jobs - 1) As Long
        ReDim s.mac1(s.jobs - 1) As Double
        ReDim s.mac2(s.jobs - 1) As Double
        Set Y = dn.cn.Execute("select job,time_dur from sp_sub1 where (sid=" & sid & " and mac=1) order by job")
        Y.MoveFirst
        While Not Y.EOF
            j.job(Y.Fields("job") - 1) = -1
            s.isomitted(Y.Fields("job") - 1) = False
            s.job(Y.Fields("job") - 1) = Y.Fields("job") - 1
            s.mac1(Y.Fields("job") - 1) = Y.Fields("time_dur")
            x.TextMatrix(1, Y.Fields("job")) = Y.Fields("time_dur")
            Y.MoveNext
        Wend
        
        Set Y = dn.cn.Execute("select job,time_dur from sp_sub1 where (sid=" & sid & " and mac=2) order by job")
        Y.MoveFirst
        While Not Y.EOF
            s.mac2(Y.Fields("job") - 1) = Y.Fields("time_dur")
            x.TextMatrix(2, Y.Fields("job")) = Y.Fields("time_dur")
            Y.MoveNext
        Wend
End Function


Public Sub nwcr_method_part2(rp As tpivot, cost As MSHFlexGrid, alloc As MSHFlexGrid)
Dim row As Integer
Dim col As Integer
Dim num As Long
Dim i As Integer

row = rp.i
col = rp.j
alloc.col = col
alloc.row = row
cost.col = col
cost.row = row
alloc.CellBackColor = RGB(300, 300, 300)
cost.CellBackColor = RGB(300, 300, 300)

num = IIf(Val(alloc.TextMatrix(alloc.rows - 1, col)) < Val(alloc.TextMatrix(row, alloc.cols - 1)), alloc.TextMatrix(alloc.rows - 1, col), alloc.TextMatrix(row, alloc.cols - 1))

alloc.TextMatrix(row, col) = str(num)
alloc.TextMatrix(alloc.rows - 1, col) = str(Val(alloc.TextMatrix(alloc.rows - 1, col)) - num)
alloc.TextMatrix(row, alloc.cols - 1) = str(Val(alloc.TextMatrix(row, alloc.cols - 1)) - num)

If Val(alloc.TextMatrix(alloc.rows - 1, col)) <= 0 Then
    For i = 1 To alloc.rows - 1 Step 1
        alloc.col = col
        alloc.row = i
        alloc.CellBackColor = RGB(182, 182, 182)
    Next i
End If

If Val(alloc.TextMatrix(row, alloc.cols - 1)) <= 0 Then
    For i = 1 To alloc.cols - 1 Step 1
        alloc.col = i
        alloc.row = row
        alloc.CellBackColor = RGB(182, 182, 182)
    Next i
End If
End Sub

Public Function mat_min_method(cost As MSHFlexGrid, alloc As MSHFlexGrid) As tpivot
Dim i As Integer
Dim j As Integer
Dim x As tpivot
Dim flg As Boolean
Dim cost1 As Double
Dim cost2 As Double

flg = False
For i = 1 To alloc.rows - 2 Step 1
    If Val(alloc.TextMatrix(i, alloc.cols - 1)) > 0 Then
        For j = 1 To alloc.cols - 2 Step 1
            If Val(alloc.TextMatrix(alloc.rows - 1, j)) > 0 Then
                cost1 = Val(cost.TextMatrix(i, j))
                If Not flg Then
                    flg = True
                    cost2 = cost1
                    x.xist = True
                    x.i = i
                    x.j = j
                Else
                    If cost2 > cost1 Then
                        cost2 = cost1
                        x.xist = True
                        x.i = i
                        x.j = j
                    End If
                End If
            End If
        Next j
    End If
Next i

If Not flg Then
    x.xist = False
Else
    alloc.col = x.j
    alloc.row = x.i
    cost.col = x.j
    cost.row = x.i
    alloc.CellBackColor = RGB(300, 300, 0)
    cost.CellBackColor = RGB(300, 300, 0)
End If

mat_min_method = x

End Function

Public Function nwcr_method(cost As MSHFlexGrid, alloc As MSHFlexGrid) As tpivot
Dim i As Integer
Dim j As Integer
Dim x As tpivot

For i = 1 To alloc.rows - 2 Step 1
    If Val(alloc.TextMatrix(i, alloc.cols - 1)) > 0 Then
        For j = 1 To alloc.cols - 2 Step 1
            If Val(alloc.TextMatrix(alloc.rows - 1, j)) > 0 Then
                alloc.col = j
                alloc.row = i
                cost.col = j
                cost.row = i
                alloc.CellBackColor = RGB(300, 300, 0)
                cost.CellBackColor = RGB(300, 300, 0)
                x.xist = True
                x.i = i
                x.j = j
                nwcr_method = x
                Exit Function
            End If
        Next j
    End If
Next i

x.xist = False
nwcr_method = x
End Function

Public Sub vam_method_part2(rp As tpivot, cost As MSHFlexGrid, alloc As MSHFlexGrid)
Dim row As Integer
Dim col As Integer
Dim num As Long
Dim i As Integer

row = rp.i
col = rp.j
alloc.col = col
alloc.row = row
cost.col = col
cost.row = row
alloc.CellBackColor = RGB(300, 300, 300)
cost.CellBackColor = RGB(300, 300, 300)

num = IIf(Val(alloc.TextMatrix(alloc.rows - 2, col)) < Val(alloc.TextMatrix(row, alloc.cols - 2)), Val(alloc.TextMatrix(alloc.rows - 2, col)), Val(alloc.TextMatrix(row, alloc.cols - 2)))

alloc.TextMatrix(row, col) = str(num)
alloc.TextMatrix(alloc.rows - 2, col) = Trim(str(Val(alloc.TextMatrix(alloc.rows - 2, col)) - num))
alloc.TextMatrix(row, alloc.cols - 2) = Trim(str(Val(alloc.TextMatrix(row, alloc.cols - 2)) - num))

If Val(alloc.TextMatrix(alloc.rows - 2, col)) <= 0 Then
    For i = 1 To alloc.rows - 1 Step 1
        alloc.col = col
        alloc.row = i
        alloc.CellBackColor = RGB(182, 182, 182)
    Next i
End If

If Val(alloc.TextMatrix(row, alloc.cols - 2)) <= 0 Then
    For i = 1 To alloc.cols - 1 Step 1
        alloc.col = i
        alloc.row = row
        alloc.CellBackColor = RGB(182, 182, 182)
    Next i
End If
End Sub

Public Function vam_method_part1(cost As MSHFlexGrid, alloc As MSHFlexGrid) As tpivot
Dim res As tpivot
Dim i As Integer
Dim j As Integer
Dim flag1 As Integer
Dim flag2 As Integer
Dim rflg As Integer
Dim src As Integer
Dim dst As Integer
Dim t1 As Double
Dim t2 As Double
Dim num As Double
Dim tmp As Double
Dim max As Double
Dim row As Integer
Dim col As Integer

src = cost.rows - 2
dst = cost.cols - 2

res.xist = False

rflg = 0

flag1 = 0
For i = 1 To src Step 1
   If Not (Val(alloc.TextMatrix(i, alloc.cols - 2)) <= 0) Then
       flag2 = 0
       For j = 1 To dst Step 1
          If Not (Val(alloc.TextMatrix(alloc.rows - 2, j)) <= 0) Then
              If flag2 = 0 Then
                t2 = Val(cost.TextMatrix(i, j))
                t1 = 0
                flag2 = flag2 + 1
              Else
                  If flag2 = 1 Then
                    num = Val(cost.TextMatrix(i, j))
                    If num < t2 Then
                        t1 = num
                    Else
                        t1 = t2
                        t2 = num
                    End If
                    flag2 = flag2 + 1
                  Else
                       num = Val(cost.TextMatrix(i, j))
                       If (num < t1) Then
                            tmp = t1
                            t1 = num
                            num = tmp
                       End If
                       If num < t2 Then
                            t2 = num
                       End If
                   End If
                End If
            End If
       Next j
        
       If Not (flag2 = 0) Then
            num = Abs(t1 - t2)
            alloc.TextMatrix(i, alloc.cols - 1) = Trim(str(num))
            If flag1 = 0 Then
                rflg = 1
                flag1 = flag1 + 1
                row = i
                max = num
            Else
                If num > max Then
                    max = num
                    row = i
                End If
            End If
       End If
   End If
Next i

If flag1 = 0 Then
    vam_method_part1 = res
    Exit Function
End If

flag1 = 0

For j = 1 To dst Step 1
   If Not (Val(alloc.TextMatrix(alloc.rows - 2, j)) <= 0) Then
        flag2 = 0
        For i = 1 To src Step 1
          If Not (Val(alloc.TextMatrix(i, alloc.cols - 2)) <= 0) Then
              If flag2 = 0 Then
                t2 = Val(cost.TextMatrix(i, j))
                t1 = 0
                flag2 = flag2 + 1
              Else
                  If flag2 = 1 Then
                    num = Val(cost.TextMatrix(i, j))
                    If num < t2 Then
                        t1 = num
                    Else
                        t1 = t2
                        t2 = num
                    End If
                    flag2 = flag2 + 1
                  Else
                       num = Val(cost.TextMatrix(i, j))
                       If (num < t1) Then
                            tmp = t1
                            t1 = num
                            num = tmp
                       End If
                       If num < t2 Then
                            t2 = num
                       End If
                  End If
              End If
          End If
        Next i

       If flag2 = 0 Then
          vam_method_part1 = res
          Exit Function
       End If
       
       num = Abs(t1 - t2)
       alloc.TextMatrix(alloc.rows - 1, j) = Trim(str(num))
       If flag1 = 0 Then flag1 = flag1 + 1
       If num > max Then
           rflg = 0
           max = num
           col = j
       End If
   End If
Next j

If flag1 = 0 Then
    vam_method_part1 = res
    Exit Function
End If

If rflg = 1 Then
   col = 0
   For j = 1 To dst Step 1
         If Val(alloc.TextMatrix(alloc.rows - 2, j)) > 0 Then
             If col = 0 Then
                col = j
             Else
                If Val(cost.TextMatrix(row, j)) < Val(cost.TextMatrix(row, col)) Then
                    col = j
                End If
             End If
         End If
    Next j
Else
   row = 0
   For i = 1 To src Step 1
         If Val(alloc.TextMatrix(i, alloc.cols - 2)) > 0 Then
             If row = 0 Then
                row = i
             Else
                If Val(cost.TextMatrix(i, col)) < Val(cost.TextMatrix(row, col)) Then
                    row = i
                End If
             End If
          End If
    Next i
End If

alloc.col = col
alloc.row = row
cost.col = col
cost.row = row
alloc.CellBackColor = RGB(300, 300, 0)
cost.CellBackColor = RGB(300, 300, 0)
res.xist = True
res.i = row
res.j = col
vam_method_part1 = res
End Function

Public Sub copy_grid1togrid2(src As MSHFlexGrid, dst As MSHFlexGrid, truecopy As Boolean, last As Boolean)
Dim i As Integer
Dim j As Integer

dst.rows = src.rows
dst.cols = src.cols
dst.clear
dst.FixedRows = src.FixedRows
dst.FixedCols = src.FixedCols

For i = 0 To src.FixedRows - 1 Step 1
    For j = 0 To src.cols - 1 Step 1
        dst.TextMatrix(i, j) = Trim(src.TextMatrix(i, j))
    Next j
Next i

For j = 0 To src.FixedCols - 1 Step 1
    For i = 0 To src.rows - 1 Step 1
        dst.TextMatrix(i, j) = Trim(src.TextMatrix(i, j))
    Next i
Next j

For i = src.FixedRows To src.rows - 1 Step 1
    For j = src.FixedCols To src.cols - 1 Step 1
        dst.TextMatrix(i, j) = IIf(truecopy, Trim(src.TextMatrix(i, j)), Trim(str(0)))
    Next j
Next i

If last Then
For j = src.FixedCols To src.cols - 2 Step 1
        dst.TextMatrix(dst.rows - 1, j) = Trim(str(src.TextMatrix(dst.rows - 1, j)))
Next j
For i = src.FixedRows To src.rows - 2 Step 1
        dst.TextMatrix(i, dst.cols - 1) = Trim(str(src.TextMatrix(i, dst.cols - 1)))
Next i
End If

End Sub

Public Function find_circuit_from(alloc As MSHFlexGrid, x As element) As vector
Dim v As vector
Dim s() As path
Dim indx() As Integer
Dim cnt As Integer
Dim i As Integer
Dim flg As Integer
Dim k As Integer

ReDim Preserve s(0) As path
s(0).isrow = True
s(0).startref = -1
s(0).reflen = -1
s(0).endstat = 0
s(0).v.len = 0
ReDim Preserve s(0).v.e(0) As element
s(0).v.e(0).i = x.i
s(0).v.e(0).j = x.j
i = 0
cnt = 0
Do While Not endcirc(s, cnt)
    flg = 0
    If s(i).endstat = 0 Then
        If s(i).isrow Then
            If s(i).v.e(s(i).v.len).i = x.i And s(i).v.e(s(i).v.len).j <> x.j Then
                s(i).endstat = 1
                flg = 2
            Else
                For k = 1 To alloc.cols - 2 Step 1
                    If Trim(alloc.TextMatrix(s(i).v.e(s(i).v.len).i, k)) <> "0" And k <> s(i).v.e(s(i).v.len).j Then
                        If flg = 0 Then
                            ReDim Preserve s(i).v.e(s(i).v.len + 1) As element
                            s(i).v.e(s(i).v.len + 1).i = s(i).v.e(s(i).v.len).i
                            s(i).v.e(s(i).v.len + 1).j = k
                            flg = 1
                            s(i).isrow = False
                        Else
                            cnt = cnt + 1
                            ReDim Preserve s(cnt) As path
                            s(cnt).isrow = False
                            s(cnt).startref = i
                            s(cnt).reflen = s(i).v.len
                            s(cnt).endstat = 0
                            s(cnt).v.len = 0
                            ReDim Preserve s(cnt).v.e(0) As element
                            s(cnt).v.e(0).i = s(i).v.e(s(i).v.len).i
                            s(cnt).v.e(0).j = k
                        End If
                    End If
                Next k
            End If
        Else
            If s(i).v.e(s(i).v.len).i <> x.i And s(i).v.e(s(i).v.len).j = x.j Then
                s(i).endstat = 1
                flg = 2
            Else
                For k = 1 To alloc.rows - 2 Step 1
                    If Trim(alloc.TextMatrix(k, s(i).v.e(s(i).v.len).j)) <> "0" And k <> s(i).v.e(s(i).v.len).i Then
                        If flg = 0 Then
                            ReDim Preserve s(i).v.e(s(i).v.len + 1) As element
                            s(i).v.e(s(i).v.len + 1).i = k
                            s(i).v.e(s(i).v.len + 1).j = s(i).v.e(s(i).v.len).j
                            flg = 1
                            s(i).isrow = True
                        Else
                            cnt = cnt + 1
                            ReDim Preserve s(cnt) As path
                            s(cnt).isrow = True
                            s(cnt).startref = i
                            s(cnt).reflen = s(i).v.len
                            s(cnt).endstat = 0
                            s(cnt).v.len = 0
                            ReDim Preserve s(cnt).v.e(0) As element
                            s(cnt).v.e(0).i = k
                            s(cnt).v.e(0).j = s(i).v.e(s(i).v.len).j
                        End If
                    End If
                Next k
            End If
        End If
    
        If flg = 1 Then
            s(i).v.len = s(i).v.len + 1
        Else
            If flg = 0 Then
                s(i).endstat = 2
            Else
                If flg = 2 Then
                    Exit Do
                End If
            End If
        End If
    End If

    i = i + 1
    If i > cnt Then i = 0
  
Loop

flg = -1
For i = 0 To cnt Step 1
    If s(i).endstat = 1 Then
        flg = i
        Exit For
    End If
Next i

        
If flg = -1 Then
    v.len = -1
    find_circuit_from = v
    Exit Function
End If

i = -1
While flg <> -1
    i = i + 1
    ReDim Preserve indx(i) As Integer
    indx(i) = flg
    flg = s(flg).startref
Wend

v.len = -1
k = 0
While i > 0
    For k = 0 To s(indx(i - 1)).reflen Step 1
        v.len = v.len + 1
        ReDim Preserve v.e(v.len) As element
        v.e(v.len).i = s(indx(i)).v.e(k).i
        v.e(v.len).j = s(indx(i)).v.e(k).j
    Next k
    i = i - 1
Wend

For k = 0 To s(indx(0)).v.len Step 1
    v.len = v.len + 1
    ReDim Preserve v.e(v.len) As element
    v.e(v.len).i = s(indx(0)).v.e(k).i
    v.e(v.len).j = s(indx(0)).v.e(k).j
Next k

find_circuit_from = v

End Function

Public Function endcirc(s() As path, cnt As Integer) As Boolean
Dim i As Integer

For i = 0 To cnt Step 1
    If s(i).endstat = 0 Then
        endcirc = False
        Exit Function
    End If
Next i

endcirc = True
End Function

Public Function get_pos(cost As MSHFlexGrid, alloc As MSHFlexGrid) As element
Dim res As element
Dim res1 As element
Dim flg As Boolean
Dim i As Integer
Dim j As Integer
Dim tmp As vector
Dim cost1 As Double

flg = False
For i = 1 To alloc.rows - 2 Step 1
    For j = 1 To alloc.cols - 2 Step 1
        If Trim(alloc.TextMatrix(i, j)) = "0" Then
            res.i = i
            res.j = j
            tmp = find_circuit_from(alloc, res)
            If tmp.len = -1 Then
                If Not flg Then
                    flg = True
                    res1 = res
                    cost1 = Val(cost.TextMatrix(i, j))
                Else
                    If Val(cost.TextMatrix(i, j)) < cost1 Then
                        res1 = res
                        cost1 = Val(cost.TextMatrix(i, j))
                    End If
                End If
            End If
        End If
    Next j
Next i

If Not flg Then
    res1.i = -1
    res1.j = -1
End If

get_pos = res1
End Function

Public Function total_allocation(alloc As MSHFlexGrid) As Integer
Dim i As Integer
Dim j As Integer
Dim cnt As Integer

cnt = 0
For i = 1 To alloc.rows - 2 Step 1
    For j = 1 To alloc.cols - 2 Step 1
        If Trim(alloc.TextMatrix(i, j)) <> "0" Then
            cnt = cnt + 1
        End If
    Next j
Next i

total_allocation = cnt
End Function

Public Function all_allocated(alloc As MSHFlexGrid) As Boolean
Dim m As Integer
Dim n As Integer
Dim k As Integer

m = alloc.rows - 2
n = alloc.cols - 2
k = total_allocation(alloc)
If k = m + n - 1 Then
    all_allocated = True
Else
    all_allocated = False
End If
End Function

Public Function make_allocation(cost As MSHFlexGrid, alloc As MSHFlexGrid) As Integer
Dim m As Integer
Dim n As Integer
Dim i As Integer
Dim k As Integer
Dim p As element

m = alloc.rows - 2
n = alloc.cols - 2
k = total_allocation(alloc)
If k = m + n - 1 Then
    make_allocation = 0
    Exit Function
End If

p = get_pos(cost, alloc)

If p.i = -1 Or p.j = -1 Then
    make_allocation = 1
Else
    make_allocation = 2
    alloc.TextMatrix(p.i, p.j) = Trim("E")
End If

End Function

Public Function max_alloc(alloc As MSHFlexGrid) As ui_vj
Dim i As Integer
Dim j As Integer
Dim tmp As Integer
Dim flg As Boolean
Dim x As ui_vj

flg = False
For i = 1 To alloc.rows - 2 Step 1
    tmp = 0
    For j = 1 To alloc.cols - 2 Step 1
        If Trim(alloc.TextMatrix(i, j)) <> "0" Then
            tmp = tmp + 1
        End If
    Next j
    If Not flg Then
        flg = True
        x.allocated = tmp
        x.isrow = True
        x.order = i
    Else
        If x.allocated < tmp Then
            x.allocated = tmp
            x.isrow = True
            x.order = i
        End If
    End If
Next i

For j = 1 To alloc.cols - 2 Step 1
    tmp = 0
    For i = 1 To alloc.rows - 2 Step 1
        If Trim(alloc.TextMatrix(i, j)) <> "0" Then
            tmp = tmp + 1
        End If
    Next i
    
    If Not flg Then
        flg = True
        x.allocated = tmp
        x.isrow = False
        x.order = j
    Else
        If x.allocated < tmp Then
            x.allocated = tmp
            x.isrow = False
            x.order = j
        End If
    End If
Next j

max_alloc = x
End Function

Public Function cal_uivj(cost As MSHFlexGrid, alloc As MSHFlexGrid, uvflex As MSHFlexGrid) As Boolean
Dim tmp As ui_vj
Dim uv As Long
Dim m As Long
Dim n As Long
Dim i As Integer
Dim j As Integer
Dim flg As Boolean

For i = 1 To uvflex.rows - 2 Step 1
    uvflex.TextMatrix(i, uvflex.cols - 1) = "NIL"
Next i

For j = 1 To uvflex.cols - 2 Step 1
    uvflex.TextMatrix(uvflex.rows - 1, j) = "NIL"
Next j

m = uvflex.rows - 2
n = uvflex.cols - 2

tmp = max_alloc(alloc)

If tmp.isrow Then
    uvflex.TextMatrix(tmp.order, uvflex.cols - 1) = 0
Else
    uvflex.TextMatrix(uvflex.rows - 1, tmp.order) = 0
End If

uv = 1
flg = True
While flg
    flg = False
    For i = 1 To uvflex.rows - 2 Step 1
        If uvflex.TextMatrix(i, uvflex.cols - 1) <> "NIL" Then
            For j = 1 To uvflex.cols - 2 Step 1
                If Trim(alloc.TextMatrix(i, j)) <> "0" Then
                    If uvflex.TextMatrix(uvflex.rows - 1, j) = "NIL" Then
                        flg = True
                        uvflex.TextMatrix(uvflex.rows - 1, j) = Trim(str(Val(cost.TextMatrix(i, j)) - Val(uvflex.TextMatrix(i, uvflex.cols - 1))))
                        uv = uv + 1
                    End If
                End If
            Next j
        End If
    Next i
    
    For j = 1 To uvflex.cols - 2 Step 1
        If uvflex.TextMatrix(uvflex.rows - 1, j) <> "NIL" Then
            For i = 1 To uvflex.rows - 2 Step 1
                If Trim(alloc.TextMatrix(i, j)) <> "0" Then
                    If uvflex.TextMatrix(i, uvflex.cols - 1) = "NIL" Then
                        flg = True
                        uvflex.TextMatrix(i, uvflex.cols - 1) = Trim(str(Val(cost.TextMatrix(i, j)) - Val(uvflex.TextMatrix(uvflex.rows - 1, j))))
                        uv = uv + 1
                    End If
                End If
            Next i
        End If
    Next j

Wend

If uv <> m + n Then
    cal_uivj = False
Else
    cal_uivj = True
End If

End Function

Public Function findnet(ner As MSHFlexGrid, cost As MSHFlexGrid, alloc As MSHFlexGrid) As tpivot
Dim i As Integer
Dim j As Integer
Dim x As tpivot
Dim t1 As Double
Dim t2 As Double
Dim flg As Boolean

flg = False
For i = 1 To ner.rows - 2 Step 1
    For j = 1 To ner.cols - 2 Step 1
        If Not Trim(alloc.TextMatrix(i, j)) <> "0" Then
            t1 = Val(ner.TextMatrix(i, ner.cols - 1)) + Val(ner.TextMatrix(ner.rows - 1, j)) - Val(cost.TextMatrix(i, j))
            ner.TextMatrix(i, j) = Trim(str(t1))
            If t1 > 0 Then
                If Not flg Then
                    t2 = t1
                    x.xist = True
                    x.i = i
                    x.j = j
                    flg = True
                Else
                    If t1 > t2 Then
                        t2 = t1
                        x.xist = True
                        x.i = i
                        x.j = j
                    End If
                End If
            End If
        End If
    Next j
Next i
                
            
If Not flg Then
    x.xist = False
End If

findnet = x

End Function
Public Function setnet_sub1(alloc As MSHFlexGrid, p As element) As vector
Dim Y As vector
Y = find_circuit_from(alloc, p)
setnet_sub1 = Y
End Function
Public Function setnet_sub2(alloc As MSHFlexGrid, Y As vector)
Dim min As String
Dim tmp As String
Dim i As Integer
Dim flg As Boolean

flg = False
For i = 0 To Y.len Step 1
    If i Mod 2 = 1 Then
        tmp = Trim(alloc.TextMatrix(Y.e(i).i, Y.e(i).j))
        If flg = False Then
            min = tmp
            flg = True
        Else
            If ep1_les_ep2(tmp, min) Then
                min = tmp
            End If
        End If
    End If
Next i
            
For i = 0 To Y.len Step 1
     tmp = Trim(alloc.TextMatrix(Y.e(i).i, Y.e(i).j))
     alloc.row = Y.e(i).i
     alloc.col = Y.e(i).j
     alloc.CellAlignment = 1
     If i Mod 2 = 0 Then
            alloc.TextMatrix(Y.e(i).i, Y.e(i).j) = Trim(add_epsilon(tmp, min))
     Else
            alloc.TextMatrix(Y.e(i).i, Y.e(i).j) = Trim(sub_epsilon(tmp, min))
    End If
Next i
        
End Function


Public Sub copy_head(g1 As MSHFlexGrid, g2 As MSHFlexGrid)
Dim i As Integer
Dim j As Integer

For i = 0 To g1.rows - 1 Step 1
    For j = 0 To g1.FixedCols - 1 Step 1
        g2.row = i
        g2.col = j
        g2.CellAlignment = 3
        g2.TextMatrix(i, j) = LCase(g1.TextMatrix(i, j))
    Next j
Next i

For j = 0 To g1.cols - 1 Step 1
    For i = 0 To g1.FixedRows - 1 Step 1
         g2.row = i
         g2.col = j
         g2.CellAlignment = 3
         g2.TextMatrix(i, j) = LCase(g1.TextMatrix(i, j))
    Next i
Next j
        

End Sub

Public Function give_sepchar(sepchar As String, length As Long) As String
Dim Y As String
Dim i As Long

Y = ""
For i = 1 To length Step 1
    Y = Y & Trim(sepchar)
Next i
give_sepchar = Y

End Function




'----------------------hungarian--------------------------'


Public Function make_asst_rowwise(x As ap) As Boolean
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim zf As Integer
Dim f1 As Boolean

f1 = False
For i = 0 To x.f.m - 1 Step 1
    If x.f.cap(i) Then
        k = -1
        zf = 0
        For j = 0 To x.d.n - 1 Step 1
            If x.d.req(j) Then
                If x.table(i, j) = 0 Then
                    zf = zf + 1
                    k = j
                End If
            End If
        Next j
        If k <> -1 And zf = 1 Then
            f1 = True
            x.alloc(i, k) = True
            x.f.cap(i) = False
            x.d.req(k) = False
            Call make_cross(x, cross, i, k, True)
        End If
    End If
Next i
        
make_asst_rowwise = f1

End Function


Public Function make_asst_colwise(x As ap) As Boolean
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim zf As Integer
Dim f2 As Boolean

f2 = False
For j = 0 To x.d.n - 1 Step 1
    If x.d.req(j) Then
        k = -1
        zf = 0
        For i = 0 To x.f.m - 1 Step 1
            If x.f.cap(i) Then
                If x.table(i, j) = 0 Then
                    zf = zf + 1
                    k = i
                End If
            End If
        Next i
        If k <> -1 And zf = 1 Then
            f2 = True
            x.alloc(k, j) = True
            x.f.cap(k) = False
            x.d.req(j) = False
            Call make_cross(x, cross, k, j, False)
        End If
    End If
Next j
make_asst_colwise = f2
End Function


Public Function find_row_min0(x As ap, ByRef col As Integer) As Integer
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim zf As Integer
Dim coln As Integer
Dim nz As Integer

k = -1
nz = -1
For i = 0 To x.f.m - 1 Step 1
    If x.f.cap(i) Then
        zf = 0
        For j = 0 To x.d.n - 1 Step 1
            If x.d.req(j) Then
                If x.table(i, j) = 0 Then
                    zf = zf + 1
                    coln = j
                End If
            End If
        Next j
        If zf >= 1 Then
            If k = -1 Then
                k = i
                nz = zf
                col = coln
            Else
                If zf <= nz Then
                   k = i
                   nz = zf
                   col = coln
                End If
            End If
        End If
    End If
Next i
find_row_min0 = k
End Function


Public Function find_col_min0(x As ap, ByRef row As Integer) As Integer
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim zf As Integer
Dim rowt As Integer
Dim nz As Integer

    k = -1
    nz = -1
    For j = 0 To x.d.n - 1 Step 1
        If x.d.req(j) Then
            zf = 0
            For i = 0 To x.f.m - 1 Step 1
                If x.f.cap(i) Then
                    If x.table(i, j) = 0 Then
                        zf = zf + 1
                        rowt = i
                    End If
                End If
            Next i
            If zf >= 1 Then
                If k = -1 Then
                    k = j
                    nz = zf
                    row = rowt
                Else
                    If zf <= nz Then
                        k = j
                        nz = zf
                        row = rowt
                    End If
                End If
            End If
        End If
    Next j
find_col_min0 = k
End Function


Public Function findcase(x As ap) As Integer
Dim n As Integer
Dim i As Integer
Dim j As Integer
Dim made As Integer

n = x.f.m
made = 0
    For i = 0 To n - 1 Step 1
        For j = 0 To x.d.n - 1 Step 1
            If x.alloc(i, j) = True Then made = made + 1
        Next j
    Next i
    
If n = made Then
    findcase = 1
Else
    findcase = findcase23(x)
End If

End Function


Public Function findcase23(x As ap) As Integer
Dim i As Integer
Dim j As Integer
Dim zf As Long

    For i = 0 To x.f.m - 1 Step 1
        If x.f.cap(i) = True Then
            zf = 0
            For j = 0 To x.d.n - 1 Step 1
                If x.d.req(j) = True Then
                    If x.table(i, j) = 0 Then zf = zf + 1
                End If
            Next j
            If zf > 1 Then
                findcase23 = 2
                Exit Function
            End If
        End If
    Next i
        
    For j = 0 To x.d.n - 1 Step 1
        If x.d.req(j) = True Then
            zf = 0
            For i = 0 To x.f.m - 1 Step 1
                If x.f.cap(i) = True Then
                    If x.table(i, j) = 0 Then zf = zf + 1
                End If
            Next i
            If zf > 1 Then
                findcase23 = 2
                Exit Function
            End If
        End If
    Next j
    
findcase23 = 3
End Function


Public Function hungarian_rowtran(Y As ap) As Boolean
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim num As Double
Dim choice As Integer
Dim x As ap

x = Y

    If x.f.m = 0 Or x.d.n = 0 Or x.f.m <> x.d.n Then
        hungarian_rowtran = False
        Exit Function
    End If
    
    For i = 0 To x.f.m - 1 Step 1
        k = 0
        For j = 1 To x.d.n - 1 Step 1
            If x.table(i, j) < x.table(i, k) Then k = j
        Next j
        
        num = x.table(i, k)
        For j = 0 To x.d.n - 1 Step 1
            x.table(i, j) = x.table(i, j) - num
        Next j
    Next i

Y = x
hungarian_rowtran = True
End Function


Public Function hungarian_coltran(Y As ap) As Boolean
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim num As Double
Dim choice As Integer
Dim x As ap

x = Y

    If x.f.m = 0 Or x.d.n = 0 Or x.f.m <> x.d.n Then
        hungarian_coltran = False
        Exit Function
    End If
    
    For j = 0 To x.d.n - 1 Step 1
        k = 0
        For i = 1 To x.f.m - 1 Step 1
            If x.table(i, j) < x.table(k, j) Then k = i
        Next i

        num = x.table(k, j)
        For i = 0 To x.f.m - 1 Step 1
            x.table(i, j) = x.table(i, j) - num
        Next i
    Next j
Y = x
hungarian_coltran = True
End Function

Public Function ummrk_mrk_rowwise(x As ap) As Boolean
Dim i As Integer
Dim f1 As Boolean
Dim row As Integer
Dim col As Integer

f1 = False
For i = 0 To x.f.m - 1 Step 1
    row = find_row_min0(x, col)
    If x.f.cap(i) And row <> -1 And row = i Then
        f1 = True
        x.alloc(row, col) = True
        x.f.cap(row) = False
        x.d.req(col) = False
        Call make_cross(x, cross, row, col, True)
    End If
Next i

ummrk_mrk_rowwise = f1

End Function

Public Function ummrk_mrk_colwise(x As ap) As Boolean
Dim j As Integer
Dim f2 As Boolean
Dim row As Integer
Dim col As Integer

f2 = False
For j = 0 To x.d.n - 1 Step 1
    col = find_col_min0(x, row)
    If x.d.req(j) And col <> -1 And col = j Then
        f2 = True
        x.alloc(row, col) = True
        x.f.cap(row) = False
        x.d.req(col) = False
        Call make_cross(x, cross, row, col, False)
    End If
Next j
ummrk_mrk_colwise = f2
End Function



Public Function draw_lines(x As ap) As line
Dim Line1 As line
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim f As Boolean
Dim cnt As Integer

ReDim Line1.cap(x.f.m) As Boolean
ReDim Line1.req(x.d.n) As Boolean
Line1.m = x.f.m
Line1.n = x.d.n

For i = 0 To Line1.m - 1 Step 1
    Line1.cap(i) = False
    Line1.req(i) = False
Next i

f = False
For i = 0 To Line1.m - 1 Step 1
    If x.f.cap(i) Then
        f = True
        Line1.cap(i) = True
    End If
Next i

While f
    f = False
    For i = 0 To x.f.m - 1 Step 1
        If Line1.cap(i) Then
            For j = 0 To x.d.n - 1 Step 1
                If Not Line1.req(j) Then
                    If x.table(i, j) = 0 Then
                        f = True
                        Line1.req(j) = True
                    End If
                End If
            Next j
        End If
    Next i
    
    For j = 0 To x.d.n - 1 Step 1
        If Line1.req(j) Then
            For i = 0 To x.f.m - 1 Step 1
                If Not Line1.cap(i) Then
                    If x.alloc(i, j) Then
                        f = True
                        Line1.cap(i) = True
                    End If
                End If
            Next i
        End If
    Next j
Wend

cnt = 0
For i = 0 To x.f.m - 1 Step 1
    Line1.cap(i) = Not Line1.cap(i)
    If Line1.cap(i) Then cnt = cnt + 1
Next i

For j = 0 To x.d.n - 1 Step 1
    If Line1.req(j) Then cnt = cnt + 1
Next j

Line1.redo = IIf(cnt = x.f.m, False, True)

draw_lines = Line1
End Function
 
 
Public Function remake_apmatrix(x As ap, l As line)
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim low As Double
Dim f As Boolean

low = 0
f = False
For i = 0 To x.f.m - 1 Step 1
    If Not l.cap(i) Then
        For j = 0 To x.d.n - 1 Step 1
            If Not l.req(j) Then
                If Not f Then
                    f = True
                    low = x.table(i, j)
                Else
                    If x.table(i, j) < low Then
                        low = x.table(i, j)
                    End If
                End If
            End If
        Next j
    End If
Next i


For i = 0 To x.f.m - 1 Step 1
    x.f.cap(i) = True
    x.d.req(i) = True
    For j = 0 To x.d.n - 1 Step 1
        x.alloc(i, j) = False
        If l.cap(i) And l.req(j) Then
            x.table(i, j) = x.table(i, j) + low
        Else
            If Not l.cap(i) And Not l.req(j) Then
                x.table(i, j) = x.table(i, j) - low
            End If
        End If
    Next j
Next i

For i = 0 To x.f.m - 1
    For j = 0 To x.d.n - 1
        x.alloc(i, j) = False
    Next j
Next i
End Function
     
  
Public Sub grid_clr(x As MSHFlexGrid, red As Integer, green As Integer, blue As Integer, Optional clrflg As Boolean)
Dim i As Integer
Dim j As Integer

For i = 1 To x.rows - 1 Step 1
    For j = 1 To x.cols - 1 Step 1
        x.row = i
        x.col = j
        x.CellBackColor = IIf(IsMissing(clrflg), RGB(red, green, blue), RGB(300, 300, 300))
    Next j
Next i
End Sub

Public Sub make_cross(aptab As ap, cross As crossed, row As Integer, col As Integer, isrow As Boolean)
Dim k As Integer
   
If isrow Then
    For k = 0 To aptab.f.m - 1 Step 1
        If k <> row And Not aptab.alloc(k, col) And aptab.table(k, col) = 0 Then
             cross.crs(k, col) = True
        End If
    Next k
Else
    For k = 0 To aptab.d.n - 1 Step 1
        If k <> col And Not aptab.alloc(row, k) And aptab.table(row, k) = 0 Then
            cross.crs(row, k) = True
        End If
    Next k
End If
   
End Sub

Public Sub clear_cross(cross As crossed)
Dim i As Integer
Dim j As Integer

ReDim cross.crs(cross.m, cross.n) As Boolean
For i = 0 To cross.m - 1 Step 1
    For j = 0 To cross.n - 1 Step 1
        cross.crs(i, j) = False
    Next j
Next i

End Sub

Public Function spaces(field_len As Long, str As String) As String
spaces = Space(IIf(Len(str) >= field_len, 0, field_len - Len(str)))
End Function

Public Function space_half(field_len As Long, str As String) As String
space_half = Space(IIf(Len(str) / 2 >= field_len, 0, field_len - Len(str) / 2))
End Function



Public Function indexincombo(comb As Control, strg As String) As Long
Dim i As Integer

indexincombo = -1
For i = 0 To comb.ListCount - 1
    If Trim(comb.List(i)) = Trim(strg) Then
        indexincombo = i
        Exit Function
    End If
Next i
    
End Function
