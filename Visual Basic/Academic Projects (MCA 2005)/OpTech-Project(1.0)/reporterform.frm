VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form r 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Problem Viewer"
   ClientHeight    =   6225
   ClientLeft      =   795
   ClientTop       =   1665
   ClientWidth     =   10260
   HelpContextID   =   3
   Icon            =   "reporterform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6225
   ScaleWidth      =   10260
   Begin RichTextLib.RichTextBox rtf 
      Height          =   6120
      Left            =   120
      TabIndex        =   0
      ToolTipText     =   "Displays Problems,Answers...You can save,copy,print by clicking the right button."
      Top             =   60
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   10795
      _Version        =   393217
      BackColor       =   16777215
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   3
      TextRTF         =   $"reporterform.frx":08CA
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComDlg.CommonDialog dialog1 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Menu opts 
      Caption         =   "&File"
      Begin VB.Menu savtofile 
         Caption         =   "Save"
         Shortcut        =   ^S
      End
      Begin VB.Menu sep 
         Caption         =   "-"
      End
      Begin VB.Menu print 
         Caption         =   "Print"
         Shortcut        =   ^P
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu cpy 
         Caption         =   "Copy"
         Shortcut        =   ^C
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu xit 
         Caption         =   "Exit"
         Shortcut        =   ^E
      End
   End
End
Attribute VB_Name = "r"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Public hold As Integer
Public flg As Integer
Public maxp As Boolean

Private Sub opts_Click()
    If Trim(rtf) <> "" Then
        If rtf.SelText <> "" Then
            cpy.Enabled = True
        Else
            cpy.Enabled = False
        End If
    End If
End Sub

Private Sub print_Click()
On Error GoTo cancel
Dim i As Integer

If Trim(rtf) <> "" Then
    rtf.SelStart = 1
    rtf.SelLength = Len(rtf)
    dialog1.PrinterDefault = True
    dialog1.ShowPrinter
    For i = 1 To dialog1.Copies
        Printer.NewPage
        rtf.SelPrint (Printer.hDC)
    Next i
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Private Sub rtf_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
If Button = vbRightButton Then
    If Trim(rtf) <> "" Then
        If rtf.SelText <> "" Then
            cpy.Enabled = True
        Else
            cpy.Enabled = False
        End If
        PopupMenu opts
    End If
  End If
End Sub

Private Sub savtofile_Click()
On Error GoTo cancel

If Trim(rtf.Text) <> "" Then
    dialog1.DefaultExt = "txt"
    dialog1.InitDir = "c:\"
    dialog1.Filter = "Text Files (*.txt)|*.txt"
    dialog1.Flags = &H2000& Or &H2& Or &H800
    dialog1.ShowSave
    rtf.SaveFile dialog1.FileName, rtfRTF
    Exit Sub
Else
    Exit Sub
End If

cancel:
   MsgBox Err.Description
End Sub

Private Sub cpy_Click()
On Error GoTo x
    If rtf.SelText <> "" Then
        Clipboard.SetText rtf.SelText, vbCFRTF
    End If
Exit Sub
x:
    MsgBox Err.Description
End Sub

Private Sub Form_load()
On Error GoTo xit
Dim t1 As String
Dim lpp As New lpp_solve
Dim Y As New Recordset
Dim y1 As New Recordset
Dim y2 As New Recordset
Dim oldn As Integer
Dim oldm As Integer
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim mx As matrix
Dim l As Integer


rtf.RightMargin = 100000
If hold = 0 Then
    If flg = 0 Then
        Call show_tpp(tpsolver.f1)
    Else
        Call ans_tpp(tpsolver.f1, tpsolver.f2)
    End If
End If
If hold = 2 Then
    If flg = 0 Then
        Call show_ap(aptab_real)
    Else
        Call ans_ap(aptab_real, aptab)
    End If
End If
With rtf
If hold = 1 Then
     If flg = 0 Then
     rtf.Text = "          " & vbCrLf & vbCrLf & vbCrLf
    Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
    t1 = "LINEAR PROGRAMMING PROBLEM DEFINITION"
    .Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
    .Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
    .Text = .Text & Trim(lpp_solve.prblm) & vbCrLf & vbCrLf
     t1 = "RESULT OF THE LINEAR PROGRAMMING PROBLEM"
    .Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
    .Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
    .Text = .Text & Trim(lpp_solve.sol) & vbCrLf & vbCrLf
    Else
        If flg = 1 Then
        rtf.Text = "          " & vbCrLf & vbCrLf & vbCrLf
    Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
    t1 = "LINEAR PROGRAMMING PROBLEM DEFINITION"
    .Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
    .Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
    .Text = .Text & Trim(lpp_solve.prblm) & vbCrLf & vbCrLf
     t1 = "DUAL OF THE LINEAR PROGRAMMING PROBLEM"
    .Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
    .Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
    .Text = .Text & Trim(lpp_solve.duals) & vbCrLf & vbCrLf
        
        End If
    End If
End If

    
End With

With rtf
If hold = 3 Then
    or_form1.pbar.Visible = True
    or_form1.pbar.Value = 0
    Call connect
    If flg = 0 Then
        i = 0
        oldn = 0
        Set Y = dn.cn.Execute("select pid,n,m from lpp_main order by n,m")
        t1 = "LINEAR PROGRAMMING PROBLEM DEFINITIONS"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        While Not Y.EOF
            If oldn < Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                i = i + 1
                j = 0
                t1 = Trim(str(i)) & ". LPP WITH VARIABLE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf & vbCrLf
            End If
            
            If oldm < Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = Trim(str(j)) & ". CONSTRAINT DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & Space(15) & t1 & vbCrLf
                .Text = .Text & Space(15) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
                k = 0
            End If
                k = k + 1
                .Text = .Text & vbCrLf & vbCrLf & Space(20) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("pid")))
                lpp.pid = Y.Fields("pid")
                lpp.type_solve = "BBM"
                lpp.Visible = False
                .Text = .Text & lpp.get_problem
            or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
            Y.MoveNext
        Wend
        If i = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
        Else
            lpp.hold = 2
            Unload lpp
        End If
        or_form1.pbar.Value = or_form1.pbar.max
        or_form1.pbar.Visible = False
    End If

    If flg = 1 Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select tid,nsrc as n,ndst as m from tpp_main where tora='T' order by nsrc,ndst")
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.Visible = True
        or_form1.pbar.Value = 0
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        t1 = "TRANSPORTATION PROBLEM DEFINITIONS"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         t1 = "ROWS:SOURCES & COLUMNS:DESTINATIONS(MATRIX ELEMENTS COST/TIME)"
         .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                l = l + 1
                j = 0
                t1 = Trim(str(l)) & ". TP WITH SOURCE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            
            If oldm <> Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = Trim(str(j)) & ". DESTINATION DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & Space(15) & t1 & vbCrLf
                .Text = .Text & Space(15) & give_sepchar("-", Len(t1)) & vbCrLf
                k = 0
            End If
                
                k = k + 1
                Set y1 = dn.cn.Execute("select t_type from tpp_main where tid=" & Y.Fields("tid"))
                .Text = .Text & vbCrLf & vbCrLf & Space(5) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("tid"))) & vbCrLf
                .Text = .Text & Space(5) & "PROBLEM TYPE:" & IIf(y1.Fields("t_type") = "MI", "MINIMIZATION", "MAXIMIZATION") & vbCrLf & vbCrLf
                t1 = "  SRC/DST:"
                For i = 1 To oldm Step 1
                    t1 = t1 & spaces(10, "D" + Trim(str(i))) & Mid("D" + Trim(str(i)), 1, 10)
                Next i
                t1 = t1 & "      CAPS"
                .Text = .Text & Space(5) & t1 & vbCrLf
                For i = 1 To oldn Step 1
                    t1 = spaces(10, "S" + Trim(str(i))) & Mid("S" + Trim(str(i)), 1, 10)
                    Set y1 = dn.cn.Execute("select cost from tpp_sub2 where(tid=" & Y.Fields("tid") & " and srcid=" & i & ") order by dstid")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(10, Trim(str(y1.Fields("cost")))) & Mid(Trim(str(y1.Fields("cost"))), 1, 10)
                        y1.MoveNext
                    Wend
                    Set y1 = dn.cn.Execute("select recap from tpp_sub1 where(tid=" & Y.Fields("tid") & " and sord='S' and sdno=" & i & ")")
                    y1.MoveFirst
                    t1 = t1 & spaces(10, Trim(str(y1.Fields("recap")))) & Mid(Trim(y1.Fields("recap")), 1, 10)
                    .Text = .Text & Space(5) & t1 & vbCrLf
                Next i
                t1 = "      REQS"
                Set y1 = dn.cn.Execute("select recap from tpp_sub1 where(tid=" & Y.Fields("tid") & " and sord='D') order by sdno")
                y1.MoveFirst
                While Not y1.EOF
                    t1 = t1 & spaces(10, Trim(str(y1.Fields("recap")))) & Mid(Trim(str(y1.Fields("recap"))), 1, 10)
                    y1.MoveNext
                Wend
                .Text = .Text & Space(5) & t1 & vbCrLf & vbCrLf
        or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
        Y.MoveNext
       Wend
       or_form1.pbar.Value = or_form1.pbar.max
       or_form1.pbar.Visible = False
       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
    End If
    
    If flg = 2 Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select tid,nsrc as n,ndst as m from tpp_main where tora='A' order by nsrc")
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.Visible = True
        or_form1.pbar.Value = 0
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        t1 = "ASSIGNMENT PROBLEM DEFINITIONS"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         t1 = "ROWS:MACHINES & COLUMNS:JOBS(MATRIX ELEMENTS COST/TIME)"
         .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                l = l + 1
                k = 0
                t1 = Trim(str(l)) & ". AP WITH MACHINE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
                
                k = k + 1
                Set y1 = dn.cn.Execute("select t_type from tpp_main where tid=" & Y.Fields("tid"))
                .Text = .Text & vbCrLf & vbCrLf & Space(5) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("tid"))) & vbCrLf
                .Text = .Text & Space(5) & "PROBLEM TYPE:" & IIf(y1.Fields("t_type") = "MI", "MINIMIZATION", "MAXIMIZATION") & vbCrLf & vbCrLf
                t1 = "  MAC/JOB:"
                For i = 1 To oldn Step 1
                    t1 = t1 & spaces(10, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 10)
                Next i
                .Text = .Text & Space(5) & t1 & vbCrLf
                For i = 1 To oldn Step 1
                    t1 = spaces(10, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 10)
                    Set y1 = dn.cn.Execute("select cost from tpp_sub2 where(tid=" & Y.Fields("tid") & " and srcid=" & i & ") order by dstid")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(10, Trim(str(y1.Fields("cost")))) & Mid(Trim(str(y1.Fields("cost"))), 1, 10)
                        y1.MoveNext
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
                Next i
                .Text = .Text & vbCrLf & vbCrLf & Space(10) & "EACH MACHINE CAN GIVE SERVICE TO A SINGLE JOB."
                .Text = .Text & vbCrLf & Space(10) & "EACH JOB REQUIRES SERVICE OF ONE & ONLY ONE MACHINE." & vbCrLf & vbCrLf
          or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
          Y.MoveNext
       Wend
       or_form1.pbar.Value = or_form1.pbar.max
       or_form1.pbar.Visible = False

       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
    End If
    
    If flg = 3 Or flg = 4 Then
        Call connect
        t1 = "SEQUENTIAL PROBLEM DEFINITIONS" & IIf(flg = 3, "(2-MACHINES & K-JOBS)", "(3-MACHINES & K-JOBS)")
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        t1 = "ROWS:JOBS & COLUMNS:MACHINES(MATRIX ELEMENTS TIME)"
        .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
        i = 0
        oldm = 0
        Set Y = dn.cn.Execute("select sid,js from sp_main where s_type='" & IIf(flg = 3, "M2", "M3") & "'")
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.Visible = True
        or_form1.pbar.Value = 0
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        While Not Y.EOF
            If oldm <> Y.Fields("js") Then
                oldm = Y.Fields("js")
                i = i + 1
                k = 0
                t1 = Trim(str(i)) & ". SP WITH JOB DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            k = k + 1
            .Text = .Text & vbCrLf & vbCrLf & Space(13) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("sid"))) & vbCrLf
            t1 = "        JOB/MAC:"
            For i = 1 To IIf(flg = 3, 2, 3) Step 1
                t1 = t1 & spaces(16, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 16)
            Next i
            .Text = .Text & Space(5) & t1 & vbCrLf
            For i = 1 To oldm Step 1
                    t1 = spaces(16, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 16)
                    Set y1 = dn.cn.Execute("select time_dur from sp_sub1 where(sid=" & Y.Fields("sid") & " and job=" & i & ") order by mac")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(16, Trim(str(y1.Fields("time_dur")))) & Mid(Trim(str(y1.Fields("time_dur"))), 1, 16)
                        y1.MoveNext
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
            Next i
            or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
            Y.MoveNext
        Wend
        If i = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
       or_form1.pbar.Value = or_form1.pbar.max
       or_form1.pbar.Visible = False
    End If
    
    If flg = 5 Then
        Call connect
        t1 = "SEQUENTIAL PROBLEM DEFINITIONS(K-MACHINES & 2-JOBS)"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        t1 = "ROWS:MACHINES & COLUMNS:JOBS(MATRIX ELEMENTS TIME)"
        .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
        i = 0
        oldm = 0
        Set Y = dn.cn.Execute("select sid,ms from sp_main where s_type='J2'")
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.Visible = True
        or_form1.pbar.Value = 0
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        While Not Y.EOF
            If oldm <> Y.Fields("ms") Then
                oldm = Y.Fields("ms")
                i = i + 1
                k = 0
                t1 = Trim(str(i)) & ". SP WITH MACHINE DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            k = k + 1
            .Text = .Text & vbCrLf & vbCrLf & Space(13) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("sid"))) & vbCrLf
            t1 = "        MAC/JOB:"
            For i = 1 To 2 Step 1
                t1 = t1 & spaces(16, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 16)
            Next i
           .Text = .Text & Space(5) & t1 & vbCrLf
            For i = 1 To oldm Step 1
                    t1 = spaces(16, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 16)
                    Set y1 = dn.cn.Execute("select time_dur from sp_sub1 where(sid=" & Y.Fields("sid") & " and mac=" & i & ") order by job")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(16, Trim(str(y1.Fields("time_dur")))) & Mid(Trim(str(y1.Fields("time_dur"))), 1, 16)
                        y1.MoveNext
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
            Next i
            .Text = .Text & vbCrLf & vbCrLf & Space(10) & "MACHINE ORDER FOR JOB-1     MACHINE ORDER FOR JOB-2" & vbCrLf
            Set y1 = dn.cn.Execute("select mac from sp_sub1 where(sid=" & Y.Fields("sid") & " and job=1) order by e_order")
            Set y2 = dn.cn.Execute("select mac from sp_sub1 where(sid=" & Y.Fields("sid") & " and job=2) order by e_order")
            y1.MoveFirst
            y2.MoveFirst
            While (Not y1.EOF And Not y2.EOF)
                t1 = "MACHINE " & Mid(Trim(y1.Fields("mac")), 1, 18)
                .Text = .Text & vbCrLf & Space(15) & t1 & spaces(18, t1)
                .Text = .Text & Space(10) & "MACHINE " & Mid(Trim(y2.Fields("mac")), 1, 18) & vbCrLf
                y1.MoveNext
                y2.MoveNext
            Wend
            Y.MoveNext
            or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
        Wend
        If i = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
        End If
        or_form1.pbar.Value = or_form1.pbar.max
        or_form1.pbar.Visible = False
    End If
    
    If flg = 6 Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select sid as tid,ms as n,js as m from sp_main where s_type='MK' order by ms,js")
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.Visible = True
        or_form1.pbar.Value = 0
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        t1 = "SEQUENTIAL PROBLEM DEFINITIONS(K MACHINES-N JOBS):"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         t1 = "ROWS:MACHINES & COLUMNS:JOBS"
         .Text = .Text & space_half(35, t1) & t1 & vbCrLf & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf & vbCrLf
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                l = l + 1
                j = 0
                t1 = Trim(str(l)) & ". SP WITH MACHINE DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            
            If oldm <> Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = Trim(str(j)) & ". JOB DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & Space(15) & t1 & vbCrLf
                .Text = .Text & Space(15) & give_sepchar("-", Len(t1)) & vbCrLf
                k = 0
            End If
                
                k = k + 1
                .Text = .Text & vbCrLf & vbCrLf & Space(5) & Trim(str(k)) & ". PROBLEM ID:" & Trim(str(Y.Fields("tid"))) & vbCrLf & vbCrLf
                t1 = "  MAC/JOB:"
                For i = 1 To oldm Step 1
                    t1 = t1 & spaces(10, "J" + Trim(str(i))) & Mid("J" + Trim(str(i)), 1, 10)
                Next i
                .Text = .Text & Space(5) & t1 & vbCrLf
                For i = 1 To oldn Step 1
                    t1 = spaces(10, "M" + Trim(str(i))) & Mid("M" + Trim(str(i)), 1, 10)
                    Set y1 = dn.cn.Execute("select time_dur as cost from sp_sub1 where(sid=" & Y.Fields("tid") & " and mac=" & i & ") order by job")
                    y1.MoveFirst
                    While Not y1.EOF
                        t1 = t1 & spaces(10, Trim(str(y1.Fields("cost")))) & Mid(Trim(str(y1.Fields("cost"))), 1, 10)
                        y1.MoveNext
                    Wend
                    .Text = .Text & Space(5) & t1 & vbCrLf
                Next i
                .Text = .Text & vbCrLf & vbCrLf
        or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
        Y.MoveNext
       Wend
       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
        or_form1.pbar.Value = or_form1.pbar.max
        or_form1.pbar.Visible = False
    End If
    
     If flg = 7 Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select matxid,rs as n,cs as m from matx_main order by rs,cs")
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.Visible = True
        or_form1.pbar.Value = 0
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        t1 = "MATRIX DEFINITIONS"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                l = l + 1
                j = 0
                t1 = Trim(str(l)) & ". MATRIX WITH ROW DEGREE " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(5) & t1 & vbCrLf
                .Text = .Text & Space(5) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            
            If oldm <> Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = Trim(str(j)) & ". COLUMN DEGREE " & Trim(str(oldm))
                .Text = .Text & vbCrLf & vbCrLf & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf
                k = 0
            End If
            Call create_matrix(Y.Fields("matxid"), mx)
            Call display_matrix(rtf, mx, 12, True, False)
        Y.MoveNext
        or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
       Wend
       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
        or_form1.pbar.Value = or_form1.pbar.max
        or_form1.pbar.Visible = False
    End If
    
    If flg = 8 Then
         t1 = "LINEAR SYSTEM OF EQUATIONS, DEFINITION"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        Call display_linear_eqns(rtf, tmp1_matx, 10, True, False)
        t1 = "SOLUTION TO THE LINEAR SYSTEM OF EQUATIONS"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        If tmp2_matx.rows > 0 Then
            t1 = ""
            For i = 0 To tmp2_matx.cols - 1 Step 1
                t1 = t1 + Space(10) + "X" + Trim(str(i + 1)) + "=" + rat_stg(tmp2_matx.matx(0, i)) + vbCrLf
            Next i
            .Text = .Text + t1
        Else
            .Text = .Text + vbCrLf + Space(10) + "No solution by CRAMER'S rule." + vbCrLf + Space(10) + "*Determinant=0."
        End If
    End If
    
     If flg = 9 Then
        l = 0
        oldn = 0
        Set Y = dn.cn.Execute("select matxid,rs as n,cs as m from matx_main where cs>=2 order by rs,cs")
        If Y.RecordCount > 0 Then Y.MoveFirst
        or_form1.pbar.Visible = True
        or_form1.pbar.Value = 0
        or_form1.pbar.max = IIf(CLng(Y.RecordCount) > 0, CLng(Y.RecordCount), 100)
        t1 = "LINEAR SYSTEM OF EQUATIONS, DEFINITIONS"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
         While Not Y.EOF
            If oldn <> Y.Fields("n") Then
                oldn = Y.Fields("n")
                oldm = 0
                l = l + 1
                j = 0
                t1 = Trim(str(l)) & ". NUMBER OF EQUATIONS " & Trim(str(oldn))
                .Text = .Text & vbCrLf & vbCrLf & vbCrLf
                .Text = .Text & Space(5) & t1 & vbCrLf
                .Text = .Text & Space(5) & give_sepchar("*", Len(t1)) & vbCrLf
            End If
            
            If oldm <> Y.Fields("m") Then
                oldm = Y.Fields("m")
                j = j + 1
                t1 = Trim(str(j)) & ". NUMBER OF UNKNOWNS " & Trim(str(oldm - 1))
                .Text = .Text & vbCrLf & vbCrLf & Space(10) & t1 & vbCrLf
                .Text = .Text & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf
                k = 0
            End If
            Call create_matrix(Y.Fields("matxid"), mx)
            Call display_linear_eqns(rtf, mx, 12, True, False)
        Y.MoveNext
        or_form1.pbar.Value = IIf(or_form1.pbar.Value < or_form1.pbar.max, or_form1.pbar.Value + 1, or_form1.pbar.max)
       Wend
       If l = 0 Then
            .Text = .Text & vbCrLf & vbCrLf & "      No stored problem in the database provided."
       End If
        or_form1.pbar.Value = or_form1.pbar.max
        or_form1.pbar.Visible = False
    End If
    
    If flg = 10 Then
         t1 = "LINEAR SYSTEM OF EQUATIONS, DEFINITION"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        Call display_linear_eqns(rtf, tmp1_matx, 10, True, False)
        t1 = "SOLUTION TO THE LINEAR SYSTEM OF EQUATIONS"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        If tmp2_matx.rows > 0 Then
            t1 = ""
            For i = 0 To tmp2_matx.cols - 1 Step 1
                t1 = t1 + Space(10) + "X" + Trim(str(i + 1)) + "=" + rat_stg(tmp2_matx.matx(0, i)) + vbCrLf
            Next i
            .Text = .Text + t1
        Else
            .Text = .Text + vbCrLf + Space(10) + "No solution by X=INVERSE(A)xB rule." + vbCrLf + Space(10) + "*Determinant=0."
        End If
    End If
End If

If hold = 4 Then
    If flg = 0 Then
        Call show_spm2(spsolver.gprblm)
    End If
    If flg = 1 Then
        Call ans_spm2(spsolver.gprblm, spsolver.gsp)
    End If
    If flg = 2 Then
        Call show_spm3(spsolver.gprblm)
    End If
    If flg = 3 Then
        Call ans_spm3(spsolver.gprblm, spsolver.gsp)
    End If
     If flg = 4 Then
        Call show_spmk(spsolver.gprblm)
    End If
    If flg = 5 Then
        Call ans_spmk(spsolver.gprblm, spsolver.gsp)
    End If
End If

If hold = 5 Then
    If flg = 0 Then
        Call show_spj2(seqj2)
    Else
        Call ans_spj2(job_mx, idles_t, seqj2)
    End If
End If

If hold = 6 Then
    .Text = "   "
    Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
    If flg = 0 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
    ElseIf flg = 1 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
        If rat_neq0(rat_stg(tmp_rat)) Or tmp1_matx.rows = tmp1_matx.cols And tmp1_matx.rows > 0 Then
            t1 = "INVERSE OF THE MATRIX"
            .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
            .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
            Call display_matrix(rtf, tmp2_matx, 5, True, True)
            .Text = .Text + vbCrLf + vbCrLf + Space(10) + "*Determinant=" + rat_stg(tmp_rat)
        Else
            t1 = "NO INVERSE EXISTS FOR THE MATRIX"
            .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
            .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
            .Text = .Text + vbCrLf + vbCrLf + Space(10) + "*Determinant" + rat_stg(tmp_rat)
        End If
    ElseIf flg = 2 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
        t1 = "ADJOINT OF THE MATRIX"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        If tmp1_matx.rows = tmp1_matx.cols And tmp1_matx.rows > 1 Then
            Call display_matrix(rtf, tmp2_matx, 5, True, True)
        Else
            .Text = .Text + vbCrLf + Space(10) + "*No Adjoint Matrix, since Matrix is not a Square Matrix/Rows<2."
        End If
    ElseIf flg = 3 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
        t1 = "ROW CANONICAL FORM OF THE MATRIX"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call display_matrix(rtf, tmp2_matx, 5, True, True)
        .Text = .Text + vbCrLf + vbCrLf + Space(10) + "*Rank of the Matrix from the Row Canonical Form=" + Trim(str(tmp1_matx.rank))
    ElseIf flg = 4 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
        t1 = "TRANSPOS OF THE MATRIX"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
         Call display_matrix(rtf, tmp2_matx, 5, True, True)
    ElseIf flg = 5 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
        t1 = "COFACTOR OF THE MATRIX"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        If tmp1_matx.rows = tmp1_matx.cols And tmp1_matx.rows > 1 Then
            Call display_matrix(rtf, tmp2_matx, 5, True, True)
        Else
            .Text = .Text + vbCrLf + Space(10) + "*No Cofactor Matrix, since Matrix is not a Square Matrix/Rows<2."
        End If
    ElseIf flg = 6 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
        t1 = "MINOR OF THE MATRIX:M" + matx1.combomin.List(matx1.combomin.ListIndex) + "."
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call display_matrix(rtf, tmp2_matx, 5, True, True)
    End If
End If

If hold = 7 Then
    .Text = "   "
    Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
    If flg = 0 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
    ElseIf flg = 1 Then
        Call display_matrix(rtf, tmp1_matx, 5, True, False)
        If matx2.opt = 1 Then
            t1 = "ROW CANONICAL FORM OF THE MATRIX"
            .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
            .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
            Call display_matrix(rtf, tmp2_matx, 5, True, True)
        End If
        t1 = "RANK OF THE MATRIX=" + Trim(str(tmp1_matx.rank)) + "."
        .Text = .Text + vbCrLf + vbCrLf + Space(10) + t1
    End If
   
End If

If hold = 8 Then
    If flg = 0 Then
        t1 = "LINEAR SYSTEM OF EQUATIONS, DEFINITION"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        Call display_linear_eqns(rtf, tmp1_matx, 10, True, False)
        t1 = "SOLUTION TO THE LINEAR SYSTEM OF EQUATIONS"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        If tmp2_matx.rows > 0 Then
            t1 = ""
            For i = 0 To tmp2_matx.cols - 1 Step 1
                t1 = t1 + Space(10) + "X" + Trim(str(i + 1)) + "=" + rat_stg(tmp2_matx.matx(0, i)) + vbCrLf
            Next i
            .Text = .Text + t1
        Else
            .Text = .Text + vbCrLf + Space(10) + "No solution by CRAMER'S rule." + vbCrLf + Space(10) + "*Determinant=0."
        End If
    End If
    If flg = 1 Then
        t1 = "LINEAR SYSTEM OF EQUATIONS, DEFINITION"
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        Call display_linear_eqns(rtf, tmp1_matx, 10, True, False)
        t1 = "SOLUTION TO THE LINEAR SYSTEM OF EQUATIONS"
        .Text = .Text + Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("~", Len(t1)) & vbCrLf
        If tmp2_matx.rows > 0 Then
            t1 = ""
            For i = 0 To tmp2_matx.cols - 1 Step 1
                t1 = t1 + Space(10) + "X" + Trim(str(i + 1)) + "=" + rat_stg(tmp2_matx.matx(0, i)) + vbCrLf
            Next i
            .Text = .Text + t1
        Else
            .Text = .Text + vbCrLf + Space(10) + "No solution by X=INVERSE(A)xB rule." + vbCrLf + Space(10) + "*Determinant=0."
        End If
    End If
End If

End With
Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub show_spj2(x As seq_j2)
Dim t1 As String
Dim t2 As String
Dim i As Integer
        
        With rtf
        t1 = "SEQUENTIAL PROBLEM DEFINITION(K-MACHINES & 2-JOBS):k=" & Trim(str(x.jd(0).cnt + 1))
        .Text = Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
        .Text = .Text & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf
        Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
        .Text = .Text & vbCrLf & vbCrLf & Space(10) & "MACHINE ORDER & TIME NEEDED ON THE MACHINE(SPECIFIED IN BRACKETS) FOR:" & vbCrLf & vbCrLf
        t1 = "JOB-1                      JOB-2                      "
        .Text = .Text & Space(10) & t1 & vbCrLf & Space(10) & give_sepchar("-", 32) & vbCrLf
        i = 0
        While i <= x.jd(0).cnt
                t1 = "MACHINE" & Mid(Trim(x.jd(0).job_mac(i) + 1) & " (" & Trim(x.jd(0).job_dur(i)) & ")", 1, 27)
                t1 = t1 & spaces(27, t1)
                t2 = "MACHINE" & Mid(Trim(x.jd(1).job_mac(i) + 1) & " (" & Trim(x.jd(1).job_dur(i)) & ")", 1, 27)
                t1 = t1 & t2
                .Text = .Text & Space(10) & t1 & vbCrLf
                i = i + 1
        Wend
        End With
End Sub

Private Sub ans_spj2(x As job_matrix, ids As optimal_spj2, Y As seq_j2)
Dim t1 As String
Dim i As Long
Dim t2 As String
Dim j As Long
Call show_spj2(Y)
With rtf

    t1 = "***OPTIMAL SCHEDULE IS GIVEN BELOW***"
    .Text = .Text & Space(10) & vbCrLf & vbCrLf & vbCrLf & space_half(35, t1) & t1 & vbCrLf
    .Text = .Text & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf
    .Text = .Text & vbCrLf & vbCrLf & Space(10) & "DETAILS OF MACHINES ALLOTED IN DIFFERENT TIME SLOTS FOR:" & vbCrLf & vbCrLf
    t1 = "JOB-1                      JOB-2"
        .Text = .Text & Space(10) & t1 & vbCrLf & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf
        i = 0
        j = 0
        While IIf(x.jg(x.optimal_schedule).j(0).cnt > x.jg(x.optimal_schedule).j(1).cnt, i, j) <= IIf(x.jg(x.optimal_schedule).j(0).cnt > x.jg(x.optimal_schedule).j(1).cnt, x.jg(x.optimal_schedule).j(0).cnt, x.jg(x.optimal_schedule).j(1).cnt)
                If i <= x.jg(x.optimal_schedule).j(0).cnt Then
                    t1 = Trim(str(x.jg(x.optimal_schedule).j(0).jp(i).low)) & "-" & Trim(str(x.jg(x.optimal_schedule).j(0).jp(i).up)) & ":" & Trim(IIf(x.jg(x.optimal_schedule).j(0).jp(i).process <> -1, "M" & Trim(str(x.jg(x.optimal_schedule).j(0).jp(i).process + 1)), "IDLE!"))
                    i = i + 1
                Else
                    t1 = ""
                End If
                t1 = t1 & spaces(27, t1)
                If j <= x.jg(x.optimal_schedule).j(1).cnt Then
                    t2 = Trim(str(x.jg(x.optimal_schedule).j(1).jp(j).low)) & "-" & Trim(str(x.jg(x.optimal_schedule).j(1).jp(j).up)) & ":" & Trim(IIf(x.jg(x.optimal_schedule).j(1).jp(j).process <> -1, "M" & Trim(str(x.jg(x.optimal_schedule).j(1).jp(j).process + 1)), "IDLE!"))
                    j = j + 1
                Else
                    t2 = ""
                End If
                t1 = t1 & t2
                .Text = .Text & Space(10) & t1 & vbCrLf
        Wend
        .Text = .Text & vbCrLf & vbCrLf & vbCrLf & Space(10) & "IDLE TIME ON MACHINE-1:" & Trim(str(ids.idle_m(0)))
        .Text = .Text & vbCrLf & vbCrLf & Space(10) & "IDLE TIME ON MACHINE-2:" & Trim(str(ids.idle_m(1)))
        .Text = .Text & vbCrLf & vbCrLf & Space(10) & "TOTAL ELAPSED TIME:" & Trim(str(ids.elapsed)) & vbCrLf & vbCrLf & vbCrLf
End With

End Sub

Private Sub Form_Resize()
    rtf.left = 50
    rtf.Top = 50
    rtf.Height = IIf(Me.ScaleHeight - 50 > 0, Me.ScaleHeight - 50, 20)
    rtf.Width = IIf(Me.ScaleWidth - 50 >= 0, Me.ScaleWidth - 50, 20)
End Sub

'Private Sub Form_Unload(cancel As Integer)
'If hold = 0 Then
'    tpsolver.Show
'End If
'If hold = 1 Then
'    lpp_solve.Show
'End If
'If hold = 2 Then
'    apsolver.Show
'End If
'If hold = 3 Then
'    or_form1.Show
'End If
'
'If hold = 4 Then
'    spsolver.Show
'End If
'
'If hold = 5 Then
'    spj2.Show
'End If
'
'If hold = 6 Then
'    matx1.Show
'End If
'
'If hold = 7 Then
'    matx2.Show
'End If
'
'If hold = 8 Then
'    foptions.Show
'End If
'End Sub



Private Sub show_tpp(cost As MSHFlexGrid)
Dim i As Integer
Dim j As Integer
Dim t1 As String

With rtf
t1 = "PROBLEM DEFINITION:" & IIf(maxp, "MAXIMIZE TRANSPORTATION PROBLEM", "MINIMIZE TRANSPORTATION PROBLEM")
rtf.Text = "                 " & vbCrLf & vbCrLf & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
.Text = .Text & Space(5) & "NUMBER OF SOURCES:" & IIf(LCase(Mid(cost.TextMatrix(cost.rows - 2, 0), 1, 2)) <> "d-", cost.rows - 2, cost.rows - 3)
.Text = .Text & vbCrLf & Space(5) & "NUMBER OF DESTINATIONS:" & Trim(str(IIf(LCase(Mid(cost.TextMatrix(0, cost.cols - 2), 1, 2)) <> "d-", cost.cols - 2, cost.cols - 3))) & vbCrLf & vbCrLf
For i = 1 To cost.rows - 2 Step 1 'IIf(LCase(Mid(cost.TextMatrix(cost.rows - 1, 0), 1, 1)) <> "s", cost.rows - 3, cost.rows - 2) Step 1
    t1 = Trim(str(i)) & ".DETAILS OF SOURCE:" & IIf(LCase(Mid(Trim(cost.TextMatrix(i, 0)), 1, 1)) <> "d", "SOURCE" & Trim(str(Val(right(Trim(cost.TextMatrix(i, 0)), 1)))), "DUMMY SOURCE")
    .Text = .Text & Space(10) & t1 & vbCrLf & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf
    .Text = .Text & Space(10) & "CAPACITY:" & Trim(cost.TextMatrix(i, cost.cols - 1)) & vbCrLf & vbCrLf
    .Text = .Text & Space(10) & IIf(maxp, "PROFIT INVOLVED IN MOVING A UNIT TO:", "COST INVOLVED IN MOVING A UNIT TO:") & vbCrLf
    For j = 1 To cost.cols - 2 Step 1 'IIf(LCase(Mid(cost.TextMatrix(0, cost.cols - 1), 1, 1)) <> "d", cost.cols - 2, cost.cols - 1) Step 1
        .Text = .Text & Space(15) & Trim(str(j)) & "." & IIf(LCase(Mid(Trim(cost.TextMatrix(0, j)), 1, 2)) <> "d-", "DESTINATION" & Trim(str(Val(right(Trim(cost.TextMatrix(0, j)), 1)))), "DUMMY DESTINATION")
        .Text = .Text & ":" & cost.TextMatrix(i, j) & vbCrLf
    Next j
    .Text = .Text & vbCrLf
Next i
    
.Text = .Text & vbCrLf & vbCrLf
For j = 1 To cost.cols - 2 Step 1
    t1 = Trim(str(j)) & ".REQUIREMENT OF DESTINATION " & IIf(LCase(Mid(Trim(cost.TextMatrix(0, j)), 1, 2)) <> "d-", "DESTINATION" & Trim(str(Val(right(Trim(cost.TextMatrix(0, j)), 1)))), "DUMMY DESTINATION") & ":" & Trim(cost.TextMatrix(cost.rows - 1, j))
   .Text = .Text & Space(10) & t1 & vbCrLf
Next j

End With
End Sub


Public Sub formattextinrtf(rtf As RichTextBox, strg As String, fnt As String, sze As Integer)

With rtf
 .SelStart = 0
 .SelStart = .Find(strg)
 .Span (strg)
 .SelColor = RGB(50, 50, 170)
 .SelFontName = "courier new"
 .SelFontSize = 9
 .SelBold = True
End With
End Sub

Private Sub ans_tpp(cost As MSHFlexGrid, alloc As MSHFlexGrid)
Dim i As Integer
Dim j As Integer
Dim t1 As String
Dim t2 As String
Dim t3 As String
Dim t4 As epsilon
Dim k As Integer
    

Call show_tpp(cost)
With rtf
t2 = "0"
.Text = .Text & vbCrLf & vbCrLf & vbCrLf
t1 = IIf(flg = 1, "OPTIMAL FEASIBLE SOLUTION", "OPTIMAL SOLUTION")
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
For j = 1 To IIf(LCase(Mid(cost.TextMatrix(0, cost.cols - 1), 1, 1)) <> "d", cost.cols - 2, cost.cols - 1) Step 1
    t1 = Trim(str(j)) & ".ALLOCATION DETAILS FOR DESTINATION " & IIf(LCase(Mid(Trim(cost.TextMatrix(0, j)), 1, 2)) <> "d-", "DESTINATION" & Trim(str(Val(right(Trim(cost.TextMatrix(0, j)), 1)))), "DUMMY DESTINATION")
    .Text = .Text & Space(10) & t1 & vbCrLf & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf
    k = 0
    For i = 1 To IIf(LCase(Mid(cost.TextMatrix(cost.rows - 1, 0), 1, 1)) <> "s" And LCase(Mid(cost.TextMatrix(cost.rows - 1, 0), 1, 1)) <> "d", cost.rows - 2, cost.rows - 1) Step 1
        If Trim(alloc.TextMatrix(i, j)) <> "0" Then
            k = k + 1
            t3 = Trim(alloc.TextMatrix(i, j))
            t4 = find_epsilon(t3)
            t2 = add_epsilon(t2, mul_epsilon(cost.TextMatrix(i, j), t3))
            t1 = Trim(str(k)) & ".FROM SOURCE " & IIf(LCase(Mid(Trim(cost.TextMatrix(i, 0)), 1, 1)) <> "d", "SOURCE" & Trim(str(Val(right(Trim(cost.TextMatrix(i, 0)), 1)))), "DUMMY SOURCE") & ":" & Trim(str(t4.n)) & IIf(t4.e <> 0, "(" & Trim(t3) & ")", "")
            .Text = .Text & Space(15) & t1 & vbCrLf
        End If
    Next i
    .Text = .Text & vbCrLf
Next j
t4 = find_epsilon(t2)
.Text = .Text & Space(5) & IIf(maxp, "TOTAL PROFIT=", "TOTAL COST=") & IIf(t4.e <> 0, Trim(t2) & "==", "") & Trim(str(t4.n)) & "." & vbCrLf & vbCrLf & vbCrLf
End With
End Sub

Private Sub show_ap(x As ap)
Dim t1 As String
Dim i As Integer
Dim j As Integer

With rtf
t1 = "PROBLEM DEFINITION:" & IIf(maxp, "MAXIMIZE ASSIGNMENT PROBLEM", "MINIMIZE ASSIGNMENT PROBLEM")
rtf.Text = "                 " & vbCrLf & vbCrLf & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
.Text = .Text & Space(5) & "NUMBER OF MACHINES:" & Trim(str(x.f.m))
.Text = .Text & vbCrLf & Space(5) & "NUMBER OF JOBS:" & Trim(str(x.d.n)) & vbCrLf & vbCrLf

For i = 0 To x.f.m - 1 Step 1
    t1 = Trim(str(i + 1)) & ".DETAILS OF MACHINE:" & Trim(str(i + 1))
    .Text = .Text & Space(10) & t1 & vbCrLf & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
    .Text = .Text & Space(10) & IIf(maxp, "ASSIGNING PROFIT TO", "ASSIGNING COST TO") & vbCrLf
    For j = 0 To x.d.n - 1 Step 1
        .Text = .Text & Space(15) & Trim(str(j + 1)) & ".JOB" & Trim(str(j + 1))
        .Text = .Text & ":" & x.table(i, j) & vbCrLf
    Next j
    .Text = .Text & vbCrLf
Next i
.Text = .Text & vbCrLf & vbCrLf & Space(10) & "EACH MACHINE CAN GIVE SERVICE TO A SINGLE JOB."
.Text = .Text & vbCrLf & Space(10) & "EACH JOB REQUIRES SERVICE OF ONE & ONLY ONE MACHINE." & vbCrLf
End With
End Sub

Private Sub ans_ap(x As ap, Y As ap)
Dim i As Integer
Dim j As Integer
Dim t1 As String
Dim t2 As Double

Call show_ap(x)
With rtf
t2 = 0
.Text = .Text & vbCrLf & vbCrLf & vbCrLf & vbCrLf
t1 = "OPTIMAL ASSIGNMENT FOR ABOVE ASSIGNMENT PROBLEM"
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf
For j = 0 To x.d.n - 1 Step 1
    t1 = Trim(str(j + 1)) & ".ALLOCATION DETAILS FOR JOB:" & Trim(str(j + 1))
    .Text = .Text & Space(10) & t1 & vbCrLf & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf
    For i = 0 To x.f.m - 1 Step 1
        If Y.alloc(i, j) Then
            t2 = t2 + x.table(i, j)
            t1 = "ALLOTED TO MACHINE:" & Trim(str(i + 1)) & "." & vbCrLf & Space(15) & IIf(maxp, "PROFIT:", "COST:") & Trim(str(x.table(i, j)))
            .Text = .Text & Space(15) & t1 & vbCrLf
            Exit For
        End If
    Next i
    .Text = .Text & vbCrLf
Next j
.Text = .Text & vbCrLf & Space(5) & IIf(maxp, "TOTAL PROFIT=", "TOTAL COST=") & Trim(str(t2))

.Text = .Text & vbCrLf & vbCrLf & vbCrLf
For i = 0 To x.f.m - 1 Step 1
    t1 = Trim(str(i + 1)) & ".ALLOCATION DETAILS FOR MACHINE:" & Trim(str(i + 1))
    .Text = .Text & Space(10) & t1 & vbCrLf & Space(10) & give_sepchar("-", Len(t1)) & vbCrLf
    For j = 0 To x.d.n - 1 Step 1
        If Y.alloc(i, j) Then
            t1 = "ALLOTED TO JOB:" & Trim(str(j + 1)) & "." & vbCrLf & Space(15) & IIf(maxp, "PROFIT:", "COST:") & Trim(str(x.table(i, j)))
            .Text = .Text & Space(15) & t1 & vbCrLf
            Exit For
        End If
    Next j
    .Text = .Text & vbCrLf
Next i

.Text = .Text & vbCrLf & Space(5) & IIf(maxp, "TOTAL PROFIT=", "TOTAL COST=") & Trim(str(t2)) & vbCrLf & vbCrLf & vbCrLf
t1 = "SUMMARY OF THE ASSIGNMENT PROBLEM"
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf
t1 = "MACHINE->JOB"
.Text = .Text & Space(5) & t1 & vbCrLf
.Text = .Text & Space(5) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf
For i = 0 To x.f.m - 1 Step 1
    For j = 0 To x.d.n - 1 Step 1
        If Y.alloc(i, j) Then
            t1 = Trim(str(i + 1)) & "-->" & Trim(str(j + 1))
            .Text = .Text & Space(10) & t1 & vbCrLf
            Exit For
        End If
    Next j
    .Text = .Text & vbCrLf
Next i

End With

End Sub

Public Sub show_spm2(x As MSHFlexGrid)
Dim t1 As String
Dim i As Integer

With rtf

t1 = "SEQUENTIAL PROBLEM(2- MACHINE & K-JOBS),K=" & Trim(str(spm2.jobs)) & "."
.Text = Space(10) & vbCrLf & vbCrLf & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf
Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
.Text = .Text & Space(5) & "JOBS MUST STRICTLY OBEY THE ORDER: MACHINE1-->MACHINE2," & vbCrLf & _
             Space(5) & "WHILE PROCESSING THROUGH THE MACHINES." & vbCrLf & Space(5) & "ALSO EACH MACHINE CAN " & _
              "COPE WITH ONLY ONE JOB AT A TIME." & vbCrLf & vbCrLf
              
.Text = .Text & Space(5) & "DETAILS OF TIME TO SPEND BY EACH JOB IN EACH MACHINE IS GIVEN BELOW." & vbCrLf & vbCrLf

For i = 1 To x.cols - 1 Step 1
    .Text = .Text & Space(10) & "TIME TO SPEND TO BY JOB-" & Trim(str(i)) & " IN:" & vbCrLf
    .Text = .Text & Space(15) & "1.MACHINE-1:" & Trim(str(x.TextMatrix(1, i))) & vbCrLf
    .Text = .Text & Space(15) & "2.MACHINE-2:" & Trim(str(x.TextMatrix(2, i))) & vbCrLf & vbCrLf
Next i

End With
End Sub



Public Sub show_spm3(x As MSHFlexGrid)
Dim t1 As String
Dim i As Integer

With rtf

t1 = "SEQUENTIAL PROBLEM(3- MACHINES & K-JOBS),K=" & Trim(str(spm3.jobs)) & "."
.Text = Space(10) & vbCrLf & vbCrLf & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf
Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
.Text = .Text & Space(5) & "JOBS MUST STRICTLY OBEY THE ORDER: MACHINE1->MACHINE2->MACHINE3," & vbCrLf & _
             Space(5) & "WHILE PROCESSING THROUGH THE MACHINES." & vbCrLf & Space(5) & "ALSO EACH MACHINE CAN " & _
              "COPE WITH ONLY ONE JOB AT A TIME." & vbCrLf & vbCrLf
              
.Text = .Text & Space(5) & "DETAILS OF TIME TO SPEND BY EACH JOB IN EACH MACHINE IS GIVEN BELOW." & vbCrLf & vbCrLf

For i = 1 To x.cols - 1 Step 1
    .Text = .Text & Space(10) & "TIME TO SPEND TO BY JOB-" & Trim(str(i)) & " IN:" & vbCrLf
    .Text = .Text & Space(15) & "1.MACHINE-1:" & Trim(str(x.TextMatrix(1, i))) & vbCrLf
    .Text = .Text & Space(15) & "2.MACHINE-2:" & Trim(str(x.TextMatrix(2, i))) & vbCrLf
    .Text = .Text & Space(15) & "3.MACHINE-3:" & Trim(str(x.TextMatrix(3, i))) & vbCrLf & vbCrLf
Next i

End With
End Sub

Public Sub show_spmk(x As MSHFlexGrid)
Dim t1 As String
Dim i As Integer
Dim j As Integer

With rtf

t1 = "SEQUENTIAL PROBLEM(K- MACHINES & N-JOBS),K=" & Trim(str(spmk.macs + 1)) & ":N=" & Trim(str(spmk.jobs + 1)) & "."
.Text = Space(10) & vbCrLf & vbCrLf & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf
Call formattextinrtf(rtf, " ", "COURIER NEW", 8)
.Text = .Text & Space(5) & "JOBS MUST STRICTLY OBEY THE ORDER: MACHINE1->.....->MACHINE" & Trim(str(spmk.macs + 1)) & "," & vbCrLf & _
             Space(5) & "WHILE PROCESSING THROUGH THE MACHINES." & vbCrLf & Space(5) & "ALSO EACH MACHINE CAN " & _
              "COPE WITH ONLY ONE JOB AT A TIME." & vbCrLf & vbCrLf
              
.Text = .Text & Space(5) & "DETAILS OF TIME TO SPEND BY EACH JOB IN EACH MACHINE IS GIVEN BELOW." & vbCrLf & vbCrLf

For i = 1 To x.cols - 1 Step 1
  .Text = .Text & Space(10) & Trim(str(i)) & ".TIME SPEND BY JOB-" & Trim(str(i)) & " IN:" & vbCrLf & vbCrLf
  For j = 1 To x.rows - 4 Step 1
    .Text = .Text & Space(15) & Trim(str(j)) & ".MACHINE-" & Trim(str(j)) & ":" & Trim(str(x.TextMatrix(j, i))) & vbCrLf
  Next j
  .Text = .Text & vbCrLf & vbCrLf
Next i

End With
End Sub

Public Sub ans_spm2(x As MSHFlexGrid, Y As MSHFlexGrid)
Dim t1 As String
Dim i As Integer


Call show_spm2(x)
t1 = "SOLUTION FOR THE SEQUENTIAL PROBLEM IS GIVEN BY"
With rtf
.Text = .Text & vbCrLf & vbCrLf & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf

For i = 1 To Y.rows - 2 Step 1
    .Text = .Text & Space(10) & "ALLOTMENT DETAILS OF  JOB-" & Trim(str(i)) & " IN:" & vbCrLf
    .Text = .Text & Space(15) & "1.MACHINE-1:(ENTERING TIME=" & Trim(str(Y.TextMatrix(i, 1))) & ",LEAVING TIME=" & Trim(str(Y.TextMatrix(i, 2))) & ")" & vbCrLf
    .Text = .Text & Space(15) & "2.MACHINE-2:(ENTERING TIME=" & Trim(str(Y.TextMatrix(i, 3))) & ",LEAVING TIME=" & Trim(str(Y.TextMatrix(i, 4))) & ")" & vbCrLf & vbCrLf
Next i

.Text = .Text & vbCrLf & vbCrLf & Space(5) & "IDLE TIME OF:" & vbCrLf
.Text = .Text & Space(10) & "1.MACHINE-1:" & Trim(str(Y.TextMatrix(Y.rows - 1, 5))) & vbCrLf
.Text = .Text & Space(10) & "2.MACHINE-2:" & Trim(str(Y.TextMatrix(Y.rows - 1, 6))) & vbCrLf
.Text = .Text & vbCrLf & Space(5) & "TOTAL ELAPSED TIME:" & Trim(str(Y.TextMatrix(Y.rows - 2, 4))) & vbCrLf & vbCrLf
End With
End Sub


Public Sub ans_spm3(x As MSHFlexGrid, Y As MSHFlexGrid)
Dim t1 As String
Dim i As Integer


Call show_spm3(x)
t1 = "SOLUTION FOR THE SEQUENTIAL PROBLEM IS GIVEN BY"
With rtf
.Text = .Text & vbCrLf & vbCrLf & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf

For i = 1 To Y.rows - 2 Step 1
    .Text = .Text & Space(10) & "ALLOTMENT DETAILS OF  JOB-" & Trim(str(i)) & " IN:" & vbCrLf
    .Text = .Text & Space(15) & "1.MACHINE-1:(ENTERING TIME=" & Trim(str(Y.TextMatrix(i, 1))) & ",LEAVING TIME=" & Trim(str(Y.TextMatrix(i, 2))) & ")" & vbCrLf
    .Text = .Text & Space(15) & "2.MACHINE-2:(ENTERING TIME=" & Trim(str(Y.TextMatrix(i, 3))) & ",LEAVING TIME=" & Trim(str(Y.TextMatrix(i, 4))) & ")" & vbCrLf
    .Text = .Text & Space(15) & "3.MACHINE-3:(ENTERING TIME=" & Trim(str(Y.TextMatrix(i, 5))) & ",LEAVING TIME=" & Trim(str(Y.TextMatrix(i, 6))) & ")" & vbCrLf & vbCrLf
Next i

.Text = .Text & vbCrLf & vbCrLf & Space(5) & "IDLE TIME OF:" & vbCrLf
.Text = .Text & Space(10) & "1.MACHINE-1:" & Trim(str(Y.TextMatrix(Y.rows - 1, 7))) & vbCrLf
.Text = .Text & Space(10) & "2.MACHINE-2:" & Trim(str(Y.TextMatrix(Y.rows - 1, 8))) & vbCrLf
.Text = .Text & Space(10) & "3.MACHINE-3:" & Trim(str(Y.TextMatrix(Y.rows - 1, 9))) & vbCrLf
.Text = .Text & vbCrLf & Space(5) & "TOTAL ELAPSED TIME:" & Trim(str(Y.TextMatrix(Y.rows - 2, 6))) & vbCrLf & vbCrLf
End With
End Sub


Public Sub ans_spmk(x As MSHFlexGrid, Y As MSHFlexGrid)
Dim t1 As String
Dim i As Integer
Dim j As Integer
Dim cnt As Long


Call show_spmk(x)
t1 = "SOLUTION FOR THE SEQUENTIAL PROBLEM IS GIVEN BY"
With rtf
.Text = .Text & vbCrLf & vbCrLf & Space(5) & space_half(35, t1) & t1 & vbCrLf
.Text = .Text & Space(5) & space_half(35, t1) & give_sepchar("-", Len(t1)) & vbCrLf & vbCrLf & vbCrLf

For i = 1 To Y.rows - 2 Step 1
    .Text = .Text & Space(10) & Trim(str(i)) & ".ALLOTMENT DETAILS OF  JOB-" & Trim(str(i)) & " IN:" & vbCrLf & vbCrLf
    cnt = 1
    For j = 1 To Y.cols - spmk.macs - 2 Step 2
        .Text = .Text & Space(15) & Trim(str(cnt)) & ".MACHINE-" & Trim(str(cnt)) & ":(ENTERING TIME=" & Trim(str(Y.TextMatrix(i, j))) & ",LEAVING TIME=" & Trim(str(Y.TextMatrix(i, j + 1))) & ")" & vbCrLf
        cnt = cnt + 1
    Next j
    .Text = .Text & vbCrLf & vbCrLf
Next i

.Text = .Text & vbCrLf & vbCrLf & Space(5) & "IDLE TIME OF:" & vbCrLf & vbCrLf
cnt = 1
For i = Y.cols - spmk.macs - 1 To Y.cols - 1 Step 1
    .Text = .Text & Space(10) & Trim(str(cnt)) & ".MACHINE-" & Trim(str(cnt)) & ":" & Trim(str(Y.TextMatrix(Y.rows - 1, i))) & vbCrLf
    cnt = cnt + 1
Next i

.Text = .Text & vbCrLf & Space(5) & "TOTAL ELAPSED TIME:" & Trim(str(Y.TextMatrix(Y.rows - 2, Y.cols - (spmk.macs + 2)))) & vbCrLf & vbCrLf
End With
End Sub


Private Sub xit_Click()
    Unload Me
End Sub
