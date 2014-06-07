//
//  KeyboardViewController.m
//  KBD
//
//  Created by Yung-Luen Lan on 6/8/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (nonatomic, strong) NSDictionary *quotes;
@end

@implementation KeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Perform custom initialization work here
    }
    return self;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Perform custom UI setup here
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.nextKeyboardButton.titleLabel.font = [UIFont systemFontOfSize :40];
    [self.nextKeyboardButton setTitle:NSLocalizedString(@"⊿", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
    [self.nextKeyboardButton sizeToFit];
    self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
    
    UIButton *achanButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [achanButton setImage: [UIImage imageNamed: @"achan"] forState: UIControlStateNormal];
    [achanButton setImage: [UIImage imageNamed: @"achan-press"] forState: UIControlStateHighlighted];
    [achanButton setImage: [UIImage imageNamed: @"achan-press"] forState: UIControlStateSelected];
    [achanButton addTarget: self action: @selector(achanSay:) forControlEvents: UIControlEventTouchUpInside];
    [achanButton sizeToFit];
    achanButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: achanButton];
    
    UIButton *kashiyukaButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [kashiyukaButton setImage: [UIImage imageNamed: @"yuka"] forState: UIControlStateNormal];
    [kashiyukaButton setImage: [UIImage imageNamed: @"yuka-press"] forState: UIControlStateHighlighted];
    [kashiyukaButton setImage: [UIImage imageNamed: @"yuka-press"] forState: UIControlStateSelected];
    [kashiyukaButton addTarget: self action: @selector(kashiyukaSay:) forControlEvents: UIControlEventTouchUpInside];
    [kashiyukaButton sizeToFit];
    kashiyukaButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: kashiyukaButton];
    
    
    UIButton *nocchiButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [nocchiButton setImage: [UIImage imageNamed: @"nocchi"] forState: UIControlStateNormal];
    [nocchiButton setImage: [UIImage imageNamed: @"nocchi-press"] forState: UIControlStateHighlighted];
    [nocchiButton setImage: [UIImage imageNamed: @"nocchi-press"] forState: UIControlStateSelected];
    [nocchiButton addTarget: self action: @selector(nocchiSay:) forControlEvents: UIControlEventTouchUpInside];
    [nocchiButton sizeToFit];
    nocchiButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: nocchiButton];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-(>=5)-[n(==a)]-[a]-[k(==a)]-(>=5)-|" options: 0 metrics: nil views: @{@"a": achanButton, @"n": nocchiButton, @"k": kashiyukaButton}];
    NSLayoutConstraint *aTopConstraint = [NSLayoutConstraint constraintWithItem: achanButton attribute:NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 10];
    NSLayoutConstraint *nTopConstraint = [NSLayoutConstraint constraintWithItem: nocchiButton attribute:NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 10];
    NSLayoutConstraint *kTopConstraint = [NSLayoutConstraint constraintWithItem: kashiyukaButton attribute:NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant: 10];
    
    [self.view addConstraints: hConstraints];
    [self.view addConstraints: @[aTopConstraint, nTopConstraint, kTopConstraint]];
    
    self.quotes = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle bundleForClass: [self class]] pathForResource: @"quotes" ofType: @"plist"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void) achanSay: (id)sender
{
    [self say: @"あ〜ちゃん"];
}

- (void) nocchiSay: (id)sender
{
    [self say: @"のっち"];
}

- (void) kashiyukaSay: (id)sender
{
    [self say: @"かしゆか"];
}

- (void) say: (NSString *)name
{
    NSString *sentence = @"パフュームです。";
    
    if ([self.quotes objectForKey: name]) {
        NSArray *sentences = [self.quotes objectForKey: name];
        sentence = [sentences objectAtIndex: arc4random() % sentences.count];
    }
    
    [self.textDocumentProxy insertText: [NSString stringWithFormat: @"%@\n", sentence]];
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
