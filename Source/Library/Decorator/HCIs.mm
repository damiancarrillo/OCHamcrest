//
//  OCHamcrest - HCIs.mm
//  Copyright 2012 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

#import "HCIs.h"

#import "HCDescription.h"
#import "HCWrapInMatcher.h"


@implementation HCIs

+ (id)is:(id<HCMatcher>)aMatcher
{
    return [[[self alloc] initWithMatcher:aMatcher] autorelease];
}

- (id)initWithMatcher:(id<HCMatcher>)aMatcher
{
    self = [super init];
    if (self)
        matcher = [aMatcher retain];
    return self;
}

- (void)dealloc
{
    [matcher release];
    [super dealloc];
}

- (BOOL)matches:(id)item
{
    return [matcher matches:item];
}

- (void)describeMismatchOf:(id)item to:(id<HCDescription>)mismatchDescription
{
    [matcher describeMismatchOf:item to:mismatchDescription];
}

- (void)describeTo:(id<HCDescription>)description
{
    [description appendDescriptionOf:matcher];
}

@end


#pragma mark -

OBJC_EXPORT id<HCMatcher> HC_is(id match)
{
    return [HCIs is:HCWrapInMatcher(match)];
}
