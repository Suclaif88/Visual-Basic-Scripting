# CursorMover.ps1

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class CursorMover {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SetCursorPos(int X, int Y);
    }
"@

while ($true) {
    [CursorMover]::SetCursorPos(500,0)
    Start-Sleep -Milliseconds 10
}
