//
//  NSString+WPAttributedMarkup.h
//  SonoRoute
//
//  Created by HBH on 07/06/2014.
//  Copyright (c) 2014 Nigel z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WPAttributedMarkup)

-(NSAttributedString*)attributedStringWithStyleBook:(NSDictionary*)styleBook;
@end

