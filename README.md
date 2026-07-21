# Windows Administration Batch Scripts

A collection of Windows command-line snippets and batch-script templates for
system and Active Directory administration.

## Script categories

### Active Directory deployment and provisioning

- `ADPromoteDC.bat` - promotes a server to a domain controller.
- `ADPromoteDCIFM.bat` - promotes a domain controller by using Install From
  Media (IFM).
- `CreateIFM.bat` - creates IFM media with `ntdsutil`.
- `ADCreateOU.bat` and `ADDeleteOU.bat` - create and remove organizational
  units.

### Active Directory replication and diagnostics

- `ADManageReplicationCMD.bat` - enables or disables inbound and outbound
  replication.
- `ADReplicationForce.bat` - forces replication across partitions and sites.
- `ADRepAdminCmd.bat` - provides a reference collection of `repadmin`
  troubleshooting commands.
- `ADScan4LingeringObjects.bat` - scans for and removes lingering directory
  objects.

### Active Directory roles, recovery, and maintenance

- `FSMOGetRoles.bat`, `FSMOMoveRoles.bat`, and `FSMOSeizeRoles.bat` - query,
  transfer, or seize FSMO roles.
- `ADSnapshotManagement.bat` - creates, lists, mounts, and exposes Active
  Directory snapshots.
- `ADSyncDSRMPassword.bat` - synchronizes a Directory Services Restore Mode
  password with a domain account.
- `ADTimeConfig.bat` - configures an authoritative time source for the PDC
  emulator.
- `GPODefaultReset.bat` - restores the default domain and domain-controller
  Group Policy objects.
- `WinBackupSysState.bat` - creates and restores Windows system-state backups.

### User profiles and file permissions

- `FolderRedirectFix.bat` - repairs redirected shell-folder registry paths.
- `FolderRedirectPermissions.bat` - configures permissions on a
  folder-redirection share.
- `TakeOwnership.bat` - takes ownership of a folder tree and resets its access
  control lists.

### Windows services

- `GerRunningSvc.bat` - lists running services and their associated accounts.
- `SetAccount4Service.bat` - changes a service account and restarts the
  service.

### Windows system administration

- `ConvertMBR2GPT.bat` - contains DiskPart commands for cleaning a disk and
  converting it from MBR to GPT.
- `UpdateWindowsProductKey.bat` - changes the Windows edition and product key
  with DISM.
- `ChromeClassFix.bat` - removes selected Chrome class-handler registry values
  from user profiles using VBScript-style WMI automation.
- `Wrapper.bat` - demonstrates a hybrid batch and PowerShell script wrapper.

## Important usage notes

These files are administrative examples and command references. Many contain
sample domain names, server names, paths, credentials, product keys, or other
placeholders that must be replaced before use. Several scripts require an
elevated Command Prompt and can make destructive or difficult-to-reverse
changes.

Read and adapt each script before running it. In particular,
`ConvertMBR2GPT.bat` includes DiskPart's `clean all` command, which erases the
selected disk. Test changes in a non-production environment and maintain a
verified backup.
