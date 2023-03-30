VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form spsolver 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SP solver"
   ClientHeight    =   6735
   ClientLeft      =   45
   ClientTop       =   660
   ClientWidth     =   11145
   HelpContextID   =   10
   Icon            =   "spsolver.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6735
   ScaleWidth      =   11145
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      Height          =   375
      Left            =   10080
      Style           =   1  'Graphical
      TabIndex        =   7
      ToolTipText     =   "Resetting to the initial state."
      Top             =   120
      Width           =   975
   End
   Begin VB.CommandButton cprev 
      BackColor       =   &H80000004&
      Caption         =   "&Previous Step"
      Height          =   375
      Left            =   5520
      Style           =   1  'Graphical
      TabIndex        =   6
      ToolTipText     =   "Building the Job queue for the current SP."
      Top             =   120
      Width           =   2535
   End
   Begin VB.CommandButton c4 
      BackColor       =   &H80000004&
      Caption         =   "&Reset"
      Height          =   375
      Left            =   9120
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "Resetting to the initial state."
      Top             =   120
      Width           =   975
   End
   Begin VB.CommandButton c1 
      BackColor       =   &H80000004&
      Caption         =   "Build Job Queue"
      Height          =   375
      Left            =   3000
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "Building the Job queue for the current SP."
      Top             =   120
      Width           =   2535
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid gprblm 
      Height          =   2775
      Left            =   135
      TabIndex        =   3
      ToolTipText     =   "Shows the current Sequential Problem."
      Top             =   720
      Width           =   11655
      _ExtentX        =   20558
      _ExtentY        =   4895
      _Version        =   393216
      BackColor       =   16777215
      BackColorFixed  =   8421504
      ForeColorFixed  =   -2147483624
      BackColorBkg    =   -2147483644
      GridColor       =   12632256
      GridColorFixed  =   16777215
      GridLines       =   3
      BorderStyle     =   0
      RowSizingMode   =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty FontFixed {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
      _Band(0).TextStyleBand=   0
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid gsp 
      Height          =   3615
      Left            =   120
      TabIndex        =   5
      ToolTipText     =   "Shows the JOB-Queue and then the solution of the current Sequential Problem."
      Top             =   3960
      Width           =   11655
      _ExtentX        =   20558
      _ExtentY        =   6376
      _Version        =   393216
      BackColor       =   16777215
      ForeColor       =   0
      BackColorFixed  =   8421504
      ForeColorFixed  =   -2147483624
      BackColorBkg    =   -2147483644
      GridColorFixed  =   16777215
      GridLines       =   3
      BorderStyle     =   0
      RowSizingMode   =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty FontFixed {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
      _Band(0).TextStyleBand=   0
   End
   Begin ComctlLib.StatusBar ssbar 
      Align           =   2  'Align Bottom
      Height          =   345
      Left            =   0
      TabIndex        =   8
      Top             =   6390
      Width           =   11145
      _ExtentX        =   19659
      _ExtentY        =   609
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   2
            TextSave        =   ""
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label l2 
      BackStyle       =   0  'Transparent
      Caption         =   "Schedule Information"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   105
      TabIndex        =   4
      Top             =   3660
      Width           =   2415
   End
   Begin VB.Label l1 
      BackStyle       =   0  'Transparent
      Caption         =   "Problem Definition"
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   2295
   End
   Begin VB.Menu opts 
      Caption         =   "&View"
      Begin VB.Menu prblm 
         Caption         =   "Problem"
         Shortcut        =   ^P
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu solution 
         Caption         =   "Solution"
         Shortcut        =   ^S
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu mexit 
         Caption         =   "Exit"
         Shortcut        =   ^E
      End
   End
End
Attribute VB_Name = "spsolver"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim qflg As Long
Public sp_id As Long
Public s_type As String
Public hold As Long
Dim cflg As Long
Dim gridflg As Boolean

Private Sub c1_Click()
On Error GoTo xit
Dim tmp1 As min_jobs
Dim tmp2 As sp_m2
    
    If s_type = "SM3" Or s_type = "SM2" Or s_type = "SMK" Then
        If qflg = -1 Then
            MsgBox "Since Min(Ai)<Max(Bi) and Min(Ci)<Max(Bi)," & vbCrLf & _
            ", Unable to find solution", vbCritical, "OpTech, Unable to find solution!!!"
            Exit Sub
        Else
            If qflg = 0 Then
                mj = find_min_spm2(spm2)
                If mj.m(0).job = -1 Then
                    qflg = 1
                    l2.Caption = "Job Queue is"
                    c1.Caption = "&Find Schedule"
                Else
                    Call addto_jobqueuem2(jq, mj)
                    l2.Caption = "Building job queue..."
                    l2.Visible = True
                    Call process_event(qflg)
                    tmp1 = mj
                    tmp2 = spm2
                    tmp1 = find_min_spm2(tmp2)
                    If tmp1.m(0).job = -1 Then
                        qflg = 1
                        l2.Caption = "Job Queue is"
                        c1.Caption = "&Find Schedule"
                    End If
                End If
                cflg = cflg + 1
                cprev.Enabled = True
                Exit Sub
            Else
                If qflg = 1 Then
                    Call process_event(qflg)
                    qflg = 2
                    c1.Caption = "&Show Schedule Information"
                    cflg = cflg + 1
                Else
                    If qflg = 2 Then
                        r.hold = 4
                        r.flg = IIf(s_type = "SM3", 3, IIf(s_type = "SM2", 1, 5))
                        r.Show vbModal
                        'Me.Hide
                    End If
                End If
                Exit Sub
            End If
        End If
    End If

Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub c4_Click()
On Error GoTo xit
    Call Form_load
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub cprev_Click()
On Error GoTo xit
Dim oldflg As Long

oldflg = cflg - 1
Call Form_load
gridflg = False
ssbar.Panels(1).Text = "Finding previous step, please wait..."
While cflg < oldflg
    If cflg = oldflg - 1 Then gridflg = True
    Call c1_Click
Wend
gridflg = True
If cflg <= 0 Then cprev.Enabled = False
ssbar.Panels(1).Text = "Step by step solving model"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_load()
On Error GoTo xit
gprblm.clear
gprblm.rows = 0
gprblm.cols = 0
gsp.clear
gridflg = True
ssbar.Panels(1).Text = "Step by step solving model"
gsp.cols = 0
gsp.rows = 0
c1.Enabled = False
l2.Visible = False
cflg = 0
cprev.Enabled = False
If s_type = "SM2" Then
    qflg = 0
    l2.Caption = "Building Job Queue..."
    c1.Caption = "&Build Job Queue"
    Call initialize_spm2(sp_id, gprblm, spm2, jq)
    c1.Enabled = True
End If

If s_type = "SM3" Then
    qflg = -1
    If initialize_spm3(sp_id, gprblm, spm3, spm2, jq) Then
        qflg = 0
        l2.Caption = "Building Job Queue..."
        c1.Caption = "&Build Job Queue"
        c1.Enabled = True
    Else
        qflg = -1
        c1.Enabled = True
        l2.Caption = "NO SOLUTION"
        c1.Caption = "&No Solution,Error!!!"
    End If
End If

If s_type = "SMK" Then
    qflg = -1
    If initialize_spmk(sp_id, gprblm, spmk, spm2, jq) Then
        qflg = 0
        l2.Caption = "Building Job Queue..."
        c1.Caption = "&Build Job Queue"
        c1.Enabled = True
    Else
        qflg = -1
        c1.Enabled = True
        l2.Caption = "NO SOLUTION"
        c1.Caption = "&No Solution,Error!!!"
    End If
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_Unload(cancel As Integer)
    If hold = 0 Then
        or_form1.Show
    ElseIf hold = 1 Then
        foptions.Show
    End If
End Sub

Public Sub process_event(flg As Long)
On Error GoTo xit
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim ina As Double
Dim inb As Double
Dim inc As Double
Dim outa As Double
Dim outb As Double
Dim outc As Double
Dim idlea As Double
Dim idleb As Double
Dim idlec As Double
Dim inm() As Double
Dim outm() As Double
Dim idlem() As Double

If Not gridflg Then Exit Sub


If (s_type = "SMK" Or s_type = "SM2" Or s_type = "SM3") And qflg = 0 Then
        gsp.clear
        gsp.rows = 0
        gsp.cols = 0
        gsp.rows = 1
        gsp.cols = gprblm.cols
        gsp.FixedCols = 1
        gsp.TextMatrix(0, 0) = "Job Order"
        For i = 0 To gsp.cols - 1 Step 1
            gsp.ColWidth(i) = 1300
        Next i
        'l2.Caption = "JOB QUEUE"
        For i = 0 To jq.cnt - 1 Step 1
            If jq.job(i) <> -1 Then
                For k = 1 To gprblm.rows - 1 Step 1
                    gprblm.row = k
                    gprblm.col = jq.job(i) + 1
                    gprblm.CellBackColor = RGB(182, 182, 182)
                Next k
                gsp.TextMatrix(0, i + 1) = "Job" & Trim(str(jq.job(i) + 1))
            Else
                gsp.TextMatrix(0, i + 1) = "NIL"
            End If
        Next i

Exit Sub
End If
        
If s_type = "SMK" And qflg = 1 Then
            gsp.clear
            l2.Caption = "Job Schedule"
            Call grid_clr(gprblm, 300, 300, 300)
            gsp.rows = jq.cnt + 2
            gsp.cols = (spmk.macs + 1) * 3 + 1
            For i = 0 To gsp.cols - 1 Step 1
                gsp.ColWidth(i) = 1300
            Next i
            gsp.FixedCols = 1
            gsp.FixedRows = 1
            For i = 1 To gsp.cols - spmk.macs - 2 Step 1
                gsp.TextMatrix(0, i) = "Mac-" & Trim(str(Int(i / 2 + 0.5))) & "(" & IIf(i Mod 2 = 1, "In", "Out") & ")"
            Next i
            j = 1
            For i = gsp.cols - spmk.macs - 1 To gsp.cols - 1 Step 1
                gsp.TextMatrix(0, i) = "Idle(Mac-" & Trim(str(j)) & ")"
                j = j + 1
            Next i
            For i = 1 To gsp.rows - 2 Step 1
                gsp.TextMatrix(i, 0) = "Job-" & Trim(str(jq.job(i - 1) + 1))
            Next i
            gsp.TextMatrix(gsp.rows - 1, 0) = "Total(Idle)"
            ReDim inm(spmk.macs) As Double
            ReDim outm(spmk.macs) As Double
            ReDim idlem(spmk.macs) As Double
            For i = 0 To spmk.macs Step 1
                inm(i) = 0
                outm(i) = 0
                idlem(i) = 0
            Next i
       
            For i = 0 To jq.cnt - 1 Step 1
                For j = 0 To spmk.macs Step 1
                    If j = 0 Then
                        inm(j) = outm(j)
                    Else
                        inm(j) = IIf(outm(j) > outm(j - 1), outm(j), outm(j - 1))
                    End If
                    idlem(j) = inm(j) - outm(j)
                    outm(j) = inm(j) + spmk.mac(j, jq.job(i))
                    gsp.TextMatrix(i + 1, j * 2 + 1) = inm(j)
                    gsp.TextMatrix(i + 1, j * 2 + 2) = outm(j)
                    gsp.TextMatrix(i + 1, (spmk.macs + 1) * 2 + j + 1) = idlem(j)
                Next j
            Next i
            
            For i = 0 To spmk.macs - 1 Step 1
                gsp.TextMatrix(gsp.rows - 2, (spmk.macs + 1) * 2 + i + 1) = Trim(str(Val(gsp.TextMatrix(gsp.rows - 2, (spmk.macs + 1) * 2 + i + 1)) + (outm(spmk.macs) - outm(i))))
            Next i
                     
            For j = 0 To spmk.macs Step 1
                idlem(j) = 0
                For i = 1 To gsp.rows - 2 Step 1
                    idlem(j) = idlem(j) + Val(gsp.TextMatrix(i, (spmk.macs + 1) * 2 + j + 1))
                Next i
                gsp.row = gsp.rows - 1
                gsp.col = (spmk.macs + 1) * 2 + j + 1
                gsp.CellFontBold = True
                gsp.TextMatrix(gsp.rows - 1, (spmk.macs + 1) * 2 + j + 1) = Trim(str(idlem(j)))
            Next j
                       
            gsp.row = gsp.rows - 2
            gsp.col = gsp.cols - (spmk.macs + 2)
            gsp.CellBackColor = RGB(300, 300, 0)
            gsp.CellFontBold = True

Exit Sub
End If



If s_type = "SM3" And qflg = 1 Then
            gsp.clear
            l2.Caption = "Job Schedule"
            Call grid_clr(gprblm, 300, 300, 300)
            gsp.rows = jq.cnt + 2
            gsp.cols = 10
            For i = 0 To gsp.cols - 1 Step 1
                gsp.ColWidth(i) = 1300
            Next i
            gsp.FixedCols = 1
            gsp.FixedRows = 1
            For i = 1 To gsp.cols - 4 Step 1
                gsp.TextMatrix(0, i) = "Mac-" & Trim(str(Int(i / 2 + 0.5))) & "(" & IIf(i Mod 2 = 1, "In", "Out") & ")"
            Next i
            gsp.TextMatrix(0, gsp.cols - 3) = "Idle(Mac-1)"
            gsp.TextMatrix(0, gsp.cols - 2) = "Idle(Mac-2)"
            gsp.TextMatrix(0, gsp.cols - 1) = "Idle(Mac-3)"
            For i = 1 To gsp.rows - 2 Step 1
                gsp.TextMatrix(i, 0) = "Job-" & Trim(str(jq.job(i - 1) + 1))
            Next i
            gsp.TextMatrix(gsp.rows - 1, 0) = "Total(Idle)"
            ina = 0
            inb = 0
            inc = 0
            outa = 0
            outb = 0
            outc = 0
            idlea = 0
            idleb = 0
            idlec = 0
            For i = 0 To jq.cnt - 1 Step 1
                ina = outa
                idlea = 0
                outa = ina + spm3.mac(0, jq.job(i))
                inb = IIf(outb > outa, outb, outa)
                idleb = inb - outb
                outb = inb + spm3.mac(1, jq.job(i))
                inc = IIf(outc > outb, outc, outb)
                idlec = inc - outc
                outc = inc + spm3.mac(2, jq.job(i))
                
                gsp.TextMatrix(i + 1, 1) = ina
                gsp.TextMatrix(i + 1, 2) = outa
                gsp.TextMatrix(i + 1, 3) = inb
                gsp.TextMatrix(i + 1, 4) = outb
                gsp.TextMatrix(i + 1, 5) = inc
                gsp.TextMatrix(i + 1, 6) = outc
                
                gsp.TextMatrix(i + 1, 7) = idlea
                gsp.TextMatrix(i + 1, 8) = idleb
                gsp.TextMatrix(i + 1, 9) = idlec
            Next i
            gsp.TextMatrix(gsp.rows - 2, 7) = Trim(str(Val(gsp.TextMatrix(gsp.rows - 2, 7)) + (outc - outa)))
            gsp.TextMatrix(gsp.rows - 2, 8) = Trim(str(Val(gsp.TextMatrix(gsp.rows - 2, 8)) + (outc - outb)))
            idlea = 0
            idleb = 0
            idlec = 0
            For i = 1 To gsp.rows - 2 Step 1
                idlea = idlea + Val(gsp.TextMatrix(i, 7))
                idleb = idleb + Val(gsp.TextMatrix(i, 8))
                idlec = idlec + Val(gsp.TextMatrix(i, 9))
            Next i
            gsp.row = gsp.rows - 1
            gsp.col = 7
            gsp.CellFontBold = True
            gsp.TextMatrix(gsp.rows - 1, 7) = Trim(str(idlea))
            gsp.row = gsp.rows - 1
            gsp.col = 8
            gsp.CellFontBold = True
            gsp.TextMatrix(gsp.rows - 1, 8) = Trim(str(idleb))
            gsp.row = gsp.rows - 1
            gsp.col = 9
            gsp.CellFontBold = True
            gsp.TextMatrix(gsp.rows - 1, 9) = Trim(str(idlec))
            
            gsp.row = gsp.rows - 2
            gsp.col = 6
            gsp.CellBackColor = RGB(300, 300, 0)
            gsp.CellFontBold = True
Exit Sub
End If


If s_type = "SM2" And qflg = 1 Then
            gsp.clear
            l2.Caption = "Job Schedule"
            Call grid_clr(gprblm, 300, 300, 300)
            gsp.rows = jq.cnt + 2
            gsp.cols = 7
            For i = 0 To gsp.cols - 1 Step 1
                gsp.ColWidth(i) = 1300
            Next i
            gsp.FixedCols = 1
            gsp.FixedRows = 1
            For i = 1 To gsp.cols - 3 Step 1
                gsp.TextMatrix(0, i) = "Mac-" & Trim(str(Int(i / 2 + 0.5))) & "(" & IIf(i Mod 2 = 1, "In", "Out") & ")"
            Next i
            gsp.TextMatrix(0, gsp.cols - 2) = "Idle(Mac-1)"
            gsp.TextMatrix(0, gsp.cols - 1) = "Idle(Mac-2)"
            For i = 1 To gsp.rows - 2 Step 1
                gsp.TextMatrix(i, 0) = "Job-" & Trim(str(jq.job(i - 1) + 1))
            Next i
            gsp.TextMatrix(gsp.rows - 1, 0) = "Total(Idle)"
            ina = 0
            inb = 0
            outa = 0
            outb = 0
            idlea = 0
            idleb = 0
            For i = 0 To jq.cnt - 1 Step 1
                ina = outa
                outa = ina + spm2.mac1(jq.job(i))
                inb = IIf(outb > outa, outb, outa)
                idleb = inb - outb
                outb = inb + spm2.mac2(jq.job(i))
                idlea = 0
                gsp.TextMatrix(i + 1, 1) = ina
                gsp.TextMatrix(i + 1, 2) = outa
                gsp.TextMatrix(i + 1, 3) = inb
                gsp.TextMatrix(i + 1, 4) = outb
                gsp.TextMatrix(i + 1, 5) = idlea
                gsp.TextMatrix(i + 1, 6) = idleb
            Next i
            gsp.TextMatrix(gsp.rows - 2, 5) = Trim(str(Val(gsp.TextMatrix(gsp.rows - 2, 5)) + (outb - outa)))
            idlea = 0
            idleb = 0
            For i = 1 To gsp.rows - 2 Step 1
                idlea = idlea + Val(gsp.TextMatrix(i, 5))
                idleb = idleb + Val(gsp.TextMatrix(i, 6))
            Next i
            gsp.row = gsp.rows - 1
            gsp.col = 5
            gsp.CellFontBold = True
            gsp.TextMatrix(gsp.rows - 1, 5) = Trim(str(idlea))
            gsp.row = gsp.rows - 1
            gsp.col = 6
            gsp.CellFontBold = True
            gsp.TextMatrix(gsp.rows - 1, 6) = Trim(str(idleb))
            gsp.row = gsp.rows - 2
            gsp.col = 4
            gsp.CellBackColor = RGB(300, 300, 0)
            gsp.CellFontBold = True
Exit Sub
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub mexit_Click()
    Unload Me
End Sub

Private Sub prblm_Click()
On Error GoTo xit
    If s_type = "SM2" Then
        r.hold = 4
        r.flg = 0
        r.Show vbModal
        'Me.Hide
    Else
        If s_type = "SM3" Then
            r.hold = 4
            r.flg = 2
            r.Show vbModal
            'Me.Hide
        Else
            r.hold = 4
            r.flg = 4
            r.Show vbModal
            'Me.Hide
        End If
    End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub solution_Click()
On Error GoTo xit

gridflg = False
ssbar.Panels(1).Text = "Finding solution, please wait..."
While Not (qflg = -1 Or qflg = 2)
    Call c1_Click
Wend
gridflg = True
Call c1_Click
ssbar.Panels(1).Text = "Step by step solving model"
Exit Sub
xit:
    Call error_me(Me)
End Sub
