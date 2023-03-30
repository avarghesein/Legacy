VERSION 5.00
Begin VB.Form ftools 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Real to Rational Converter"
   ClientHeight    =   4815
   ClientLeft      =   2340
   ClientTop       =   2220
   ClientWidth     =   6975
   ClipControls    =   0   'False
   HelpContextID   =   12
   Icon            =   "ftools.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   3323.399
   ScaleMode       =   0  'User
   ScaleWidth      =   6549.886
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox t1 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1395
      MaxLength       =   20
      TabIndex        =   8
      Top             =   135
      Width           =   2655
   End
   Begin VB.TextBox t2 
      Alignment       =   1  'Right Justify
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1380
      Locked          =   -1  'True
      MaxLength       =   30
      TabIndex        =   7
      Top             =   960
      Width           =   2655
   End
   Begin OpTech_demo.datecalculatordemo2 datecalculatordemo21 
      Height          =   4575
      Left            =   0
      TabIndex        =   5
      Top             =   240
      Width           =   4545
      _ExtentX        =   8017
      _ExtentY        =   8070
   End
   Begin VB.CommandButton c3 
      Caption         =   "E&xit"
      Height          =   375
      Left            =   5760
      TabIndex        =   4
      Top             =   960
      Width           =   1095
   End
   Begin VB.CommandButton c2 
      Caption         =   "Cl&ear"
      Height          =   375
      Left            =   4200
      TabIndex        =   3
      Top             =   960
      Width           =   1335
   End
   Begin VB.CommandButton c1 
      Caption         =   "Convert to &Rational Number"
      Height          =   375
      Left            =   4200
      TabIndex        =   0
      Top             =   135
      Width           =   2655
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      BorderStyle     =   6  'Inside Solid
      Index           =   4
      X1              =   0
      X2              =   6535.801
      Y1              =   496.957
      Y2              =   496.957
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   6535.801
      Y1              =   496.957
      Y2              =   496.957
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "Date Calculator"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   225
      TabIndex        =   6
      Top             =   15
      Width           =   4095
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      BorderStyle     =   6  'Inside Solid
      Index           =   3
      X1              =   0
      X2              =   6535.801
      Y1              =   1076.74
      Y2              =   1076.74
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   6535.801
      Y1              =   1076.74
      Y2              =   1076.74
   End
   Begin VB.Label Label2 
      Caption         =   "Rational Number"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   1035
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Real Number"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   195
      Width           =   1215
   End
   Begin VB.Menu opts 
      Caption         =   "&Options"
      Begin VB.Menu acon 
         Caption         =   "Auto Convert"
         Shortcut        =   ^A
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu cfsr 
         Caption         =   "Convert for small Rational"
         Shortcut        =   ^S
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu cfea 
         Caption         =   "Convert for best approximation"
         Shortcut        =   ^E
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu xit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu cexit 
      Caption         =   "E&xit"
   End
End
Attribute VB_Name = "ftools"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim backup As String

Private Sub acon_Click()
On Error GoTo xit
    acon.Checked = Not acon.Checked
    If acon.Checked Then
        c1.Enabled = False
    Else
        c1.Enabled = True
    End If
    Call c2_Click
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub c1_Click()
On Error GoTo xit
Dim d_len As Long
    If t1 = "" Then
        t2 = "no real number to convert"
        If c1.Enabled Then c1.SetFocus
    ElseIf cfsr.Checked Then
        d_len = search_string(t1, ".")
        If d_len <= 0 Then
            d_len = 0
        Else
            d_len = Len(Mid(t1, d_len + 1, Len(t1) - d_len))
            d_len = IIf(d_len > 10, 10, d_len)
        End If
        t2 = real_rat(Val(t1), 1# / (10 ^ d_len))
    ElseIf cfea.Checked Then
        d_len = search_string(t1, ".")
        If d_len <= 0 Then
            d_len = 0
        Else
            d_len = Len(Mid(t1, d_len + 1, Len(t1) - d_len))
            d_len = IIf(d_len > 10, 10, d_len)
        End If
        t2 = real_rat_accurate(Val(t1), 1# / (10 ^ d_len))
    End If
Exit Sub
xit:
    'Call error_me(Me)
    t2 = "Real value too big for conversion!"
End Sub

Private Sub c2_Click()
    t2 = ""
    t1 = ""
    backup = ""
    t2 = "no real number to convert"
    If Me.Visible And t1.Visible And t1.Enabled Then t1.SetFocus
End Sub

Private Sub c3_Click()
    Unload Me
End Sub

Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub cfea_Click()
    cfea.Checked = Not cfea.Checked
    cfsr.Checked = Not cfea.Checked
End Sub

Private Sub cfsr_Click()
    cfsr.Checked = Not cfsr.Checked
    cfea.Checked = Not cfsr.Checked
End Sub

Private Sub Form_activate()
On Error GoTo xit
    If acon.Visible Then
        acon.Checked = True
        c1.Enabled = False
        cfsr.Checked = True
        cfea.Checked = False
     End If
    Call c2_Click
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub t1_Change()
    Call is_valid_textsub(t1, backup, True, True)
    If acon.Checked Then
         Call c1_Click
    End If
End Sub

Private Sub t1_KeyPress(pKey As Integer)
On Error GoTo xit
    
    If pKey = vbKeyBack Then Exit Sub
        
    If pKey = 13 Then
        Call is_valid_text(t1, backup, True, True)
        backup = ""
        Call c1_Click
        Exit Sub
    End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub xit_Click()
    Unload Me
End Sub


Public Function real_rat_accurate(num As Double, accuracy As Double) As String
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
    Y = Mid(dec_part, 1, Len(dec_part))
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
        If is_pattern_repeating(Y, 2, False) Then
            i1 = Mid(Y, 1, 2)
            i2 = "99"
        ElseIf is_subpattern_repeating(Y, 2, False) Then
            i1 = Trim(str(Val(Mid(Y, 1, 2)) - Val(Mid(Y, 1, 1))))
            i2 = "90"
        Else
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
            real_rat_accurate = rat_stg(r)
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
real_rat_accurate = rat_stg(r)
End Function
