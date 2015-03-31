// VENToken.m
//
// Copyright (c) 2014 Venmo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VENToken.h"

@interface VENToken ()
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@end

@implementation VENToken {
	CAShapeLayer *_backgroundLayer;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit
{
	self.clipsToBounds = YES;
	self.userInteractionEnabled = YES;
    self.layer.cornerRadius = 5;
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapToken:)];
    self.colorScheme = [UIColor blueColor];
    self.textColor = self.colorScheme;
	[self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)setText:(NSString *)text
{
	[super setText:text];
    self.textColor = self.colorScheme;
    [self sizeToFit];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetMaxX(self.frame) + 3, CGRectGetHeight(self.frame));
}
- (CGSize)sizeThatFits:(CGSize)size {
	CGSize s = [super sizeThatFits:size];
	s.width += VENToken.padding.left + VENToken.padding.right;
	return s;
}

- (void)drawTextInRect:(CGRect)rect {
	[super drawTextInRect:UIEdgeInsetsInsetRect(rect, [VENToken padding])];
}


+ (UIEdgeInsets)padding {
	return UIEdgeInsetsMake(0, 4, 0, 4);
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
    UIColor *textColor = self.highlighted ? [UIColor whiteColor] : self.colorScheme;
    UIColor *backgroundColor = self.highlighted ? self.colorScheme : [UIColor clearColor];
    self.textColor = textColor;
    self.backgroundColor = backgroundColor;
}

- (void)layoutSubviews {
	
}
- (void)setColorScheme:(UIColor *)colorScheme
{
    _colorScheme = colorScheme;
    self.textColor = self.colorScheme;
    [self setHighlighted:self.highlighted];
}

#pragma mark - Private

- (void)didTapToken:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (self.didTapTokenBlock) {
        self.didTapTokenBlock();
    }
}

@end
