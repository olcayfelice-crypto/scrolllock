Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized
$form.TopMost = $true
$form.DoubleBuffered = $true

$colors = @(
    [System.Drawing.Color]::DeepPink,
    [System.Drawing.Color]::DodgerBlue,
    [System.Drawing.Color]::Yellow,
    [System.Drawing.Color]::Red,
    [System.Drawing.Color]::LimeGreen,
    [System.Drawing.Color]::Purple
)

$index = 0

# Kareleri oluştur
for ($i = 0; $i -lt 30; $i++) {

    $p = New-Object System.Windows.Forms.Panel

    $size = Get-Random -Minimum 30 -Maximum 120

    $p.Width = $size
    $p.Height = $size

    $p.Left = Get-Random -Minimum 0 -Maximum 1200
    $p.Top = Get-Random -Minimum 0 -Maximum 700

    $p.BackColor = $colors[(Get-Random -Minimum 0 -Maximum $colors.Count)]

    $form.Controls.Add($p)
}

# Efekt zamanlayıcısı
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 100

$timer.Add_Tick({

    # Arka plan rengini değiştir
    $script:index++

    if ($script:index -ge $colors.Count) {
        $script:index = 0
    }

    $form.BackColor = $colors[$script:index]

    # Kareleri hareket ettir
    foreach ($p in $form.Controls) {

        $p.Left += Get-Random -Minimum -25 -Maximum 26
        $p.Top += Get-Random -Minimum -20 -Maximum 21

        if ($p.Left -gt $form.Width) {
            $p.Left = -$p.Width
        }

        if ($p.Left -lt -$p.Width) {
            $p.Left = $form.Width
        }

        if ($p.Top -gt $form.Height) {
            $p.Top = -$p.Height
        }

        if ($p.Top -lt -$p.Height) {
            $p.Top = $form.Height
        }

        # Kare rengi
        if ((Get-Random -Minimum 0 -Maximum 3) -eq 0) {
            $p.BackColor = $colors[
                (Get-Random -Minimum 0 -Maximum $colors.Count)
            ]
        }
    }

    $form.Refresh()
})

$timer.Start()

# 10 dakika sonra kapanması
$closeTimer = New-Object System.Windows.Forms.Timer
$closeTimer.Interval = 600000

$closeTimer.Add_Tick({
    $timer.Stop()
    $closeTimer.Stop()
    $form.Close()
})

$closeTimer.Start()

# Göster
[System.Windows.Forms.Application]::Run($form)