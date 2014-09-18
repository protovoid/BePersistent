//
//  PersistentViewController.m
//  BePersistent
//
//  Created by Joshua Howland on 9/15/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PersistentViewController.h"

static NSString * const scoreKey = @"scoreKey";
static NSString * const playerKey = @"playerKey";
static NSString * const playerNameKey = @"playerNameKey";

@interface PersistentViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;

@property (strong, nonatomic) IBOutlet UIButton *loadButton;


@end

@implementation PersistentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textField.delegate = self;
    
    NSDictionary *player = [[NSUserDefaults standardUserDefaults] objectForKey:playerKey];
    
    [self updateWithDictionary:player];
    
    /*
    NSString *score = [[[NSUserDefaults standardUserDefaults] objectForKey:scoreKey] stringValue];
    
    if (score) { // checks if score is not nil
        self.label.text = score;
    }
    

    self.label.text =
    [[[NSUserDefaults standardUserDefaults] objectForKey:scoreKey] stringValue];
    */
    
    
}


- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
    NSNumber *score = dictionary[scoreKey];
    
    if (score) {
        self.label.text = [score stringValue];
        self.stepper.value = [score doubleValue];
    }
    
    NSString *name = dictionary[playerNameKey];
    
    if (name) {
        self.textField.text = name;
    }
    
}


- (IBAction)loadSaveData:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.textField.text = [defaults objectForKey:@"data"];
}



- (IBAction)changeScore:(id)sender {
    self.label.text = [NSString stringWithFormat:@"%d", (int)self.stepper.value];
}




- (IBAction)save:(id)sender {
    
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.textField.text forKey:@"data"];
    
    // creating dictionary
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[scoreKey] = self.label.text;
    
    [[NSUserDefaults standardUserDefaults] setValue:self.label.text forKey:scoreKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(self.stepper.value) forKey:scoreKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize]; // forces data to be saved (synchronized)
     */
    
    NSMutableDictionary *player = [NSMutableDictionary new];
    
    if (self.textField.text) {
        [player setObject:self.textField.text forKey:playerNameKey];
    }
    
    [player setObject:@(self.stepper.value) forKey:scoreKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:player forKey:playerKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
