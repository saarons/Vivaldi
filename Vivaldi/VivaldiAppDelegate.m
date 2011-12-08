//
//  VivaldiAppDelegate.m
//  Vivaldi
//
//  Created by Sam Aarons on 12/5/11.
//  Copyright 2011 Sam Aarons. All rights reserved.
//

#import "VivaldiAppDelegate.h"

@implementation VivaldiAppDelegate

- (void)mediaKeyEvent: (int)key state: (BOOL)state repeat: (BOOL)repeat
{
    NSAppleScript *script = [NSAppleScript new];
	switch( key )
	{
		case NX_KEYTYPE_PLAY:
			if( state )
                [script initWithSource: @"tell application \"System Events\" to key code 100"];
            break;
            
		case NX_KEYTYPE_FAST:
			if( state )
                [script initWithSource: @"tell application \"System Events\" to key code 101"];
            break;
            
		case NX_KEYTYPE_REWIND:
			if( state )
                [script initWithSource: @"tell application \"System Events\" to key code 98"];
            break;
	}
    [script executeAndReturnError:nil];
}

- (void)sendEvent: (NSEvent*)event
{
	if( [event type] == NSSystemDefined && [event subtype] == 8 )
	{
		int keyCode = (([event data1] & 0xFFFF0000) >> 16);
		int keyFlags = ([event data1] & 0x0000FFFF);
		int keyState = (((keyFlags & 0xFF00) >> 8)) ==0xA;
		int keyRepeat = (keyFlags & 0x1);
		
		[self mediaKeyEvent: keyCode state: keyState repeat: keyRepeat];
	}
}

@end
