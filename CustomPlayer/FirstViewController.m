//
//  FirstViewController.m
//  CustomPlayer
//
//  Created by Администратор on 4/11/13.
//  Copyright (c) 2013 gbksoft.com. All rights reserved.
//

#import "FirstViewController.h"

//#define START 74
//#define END 256

#define START 0
#define END 186

@interface FirstViewController ()

@end

@implementation FirstViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Stream Video";
   // NSString *mediaPath =@"https://www.facebook.com/photo.php?v=379411858834268";
    NSURL *url =[[NSBundle mainBundle] URLForResource: @"Movie" withExtension:@"mp4"];
    //NSURL *url =[[NSBundle mainBundle] URLForResource: @"sample" withExtension:@"mov"];
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://movies.apple.com/media/us/mac/getamac/2009/apple-mvp-biohazard_suit-us-20090419_480x272.mov"]];
    if(url)
    {
        //@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
        self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        self.player.view.frame = CGRectMake(0, 0,self.videoThumbnail.frame.size.width,self.videoThumbnail.frame.size.height);
        [self.videoThumbnail addSubview: self.player.view];
        self.player.controlStyle = MPMovieControlStyleNone;
        self.player.fullscreen = YES;
        [self.player prepareToPlay];
         self.player.shouldAutoplay = NO;
        
    }

    
    self.playbackView = [[UIView alloc] initWithFrame:CGRectZero];
    self.playbackView.backgroundColor = [UIColor colorWithRed:242.0/255 green:163.0/255 blue:10.0/255 alpha:1];
    //self.playbackView.layer.cornerRadius = 2;
    [self.view addSubview:self.playbackView];
    
    
    self.slider.minimumValue = START;
    self.slider.maximumValue = END;

    UIImage *ball = [UIImage imageNamed:@"player-handle"];
    [self.slider setThumbImage:ball forState:UIControlStateNormal];
    [self.slider setThumbImage:ball forState:UIControlStateHighlighted];
    [self.slider setMinimumTrackTintColor:[UIColor colorWithRed:242.0/255 green:163.0/255 blue:10.0/255 alpha:1]];
    
    
    
    

}


-(IBAction)playVideo:(id)sender
{
    
    //[[GApi sharedInstance] fbRequestVideo:@"369290943179693"];
    
    if(self.player.playbackState == MPMoviePlaybackStatePlaying)
    {
        NSLog(@"Yes Playing");
        [self.playerBtn setImage:[UIImage imageNamed:@"player-btn-play"] forState:UIControlStateNormal];
        [self.player pause];
    }
    else
    {
        NSLog(@"Not Playing");
        [self.player play];
        [self.playerBtn setImage:[UIImage imageNamed:@"player-btn-pause"] forState:UIControlStateNormal];
        [self watcher];
    }
}



- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    NSError *error = [[notification userInfo] objectForKey:@"error"];
    if (error) {
        NSLog(@"Did finish with error: %@", error);
    }
}


 
-(void)watcher{
    if([[NSString stringWithFormat:@"%f", self.player.currentPlaybackTime] isEqualToString:@"nan"])
    {
        NSLog(@"Sorry,video can't be played");
        //[self showAlertError:@"Sorry,video can't be played"];
        return;
    }
    
    
    
    float currentTime = self.player.currentPlaybackTime;
    
    self.lProgress.textAlignment = NSTextAlignmentCenter;
    self.lProgress.text = [self timeFormat:currentTime];
    [self performSelector:@selector(watcher) withObject:nil afterDelay:0.5];//to update the value each 0.5 seconds
    
    float rate = (END - START) / self.player.duration;
 //   self.playbackView.frame = CGRectMake(74, 306.5, (rate * currentTime) ,5);

    NSLog(@" _CC_ %f = , %f =",rate,currentTime);
    
    self.slider.value = rate * currentTime;
 
 
}

- (IBAction) onTimeSliderChange: (UISlider*)sender
{
    NSLog(@"_Value__Changed__");

    float rate = self.player.duration / (END - START);
    float _time =  rate * self.slider.value;
    self.player.currentPlaybackTime = _time;//totalVideoTime / END;
    float currentTime = self.player.currentPlaybackTime;
    self.lProgress.text = [self timeFormat:currentTime];

}





//-(void)watcher{
//    
//    float currentTime = player.currentPlaybackTime;
//    urProgressLabel.text = [self timeFormat:currentTime];
//    [self performSelector:@selector(watcher) withObject:nil afterDelay:0.5];//to update the value each 0.5 seconds
//    
//    float rate = (END - START) / player.duration;
//    self.playbackView.frame = CGRectMake(10, 200, (rate * currentTime) , 8);
//}

- (NSString *) timeFormat: (float) seconds {
    int hours = seconds / 3600;
    int minutes = seconds / 60;
    int sec = fabs(round((int)seconds % 60));
    NSString *ch = hours <= 9 ? @"0": @"";
    NSString *cm = minutes <= 9 ? @"0": @"";
    NSString *cs = sec <= 9 ? @"0": @"";
    return [NSString stringWithFormat:@"%@%i:%@%i:%@%i", ch, hours, cm, minutes, cs, sec];
}



 

//- (IBAction)movie:(id)sender{
//    
//    if(self.player.playbackState == MPMoviePlaybackStatePlaying)
//    {
//        NSLog(@"Yes Playing");
//        //[playerBtn setImage:[UIImage imageNamed:@"player-btn-play"] forState:UIControlStateNormal];
//        [self.player pause];
//    }
//    else
//    {
//        NSLog(@"Not Playing");
//        [self.player play];
//        //[playerBtn setImage:[UIImage imageNamed:@"player-btn-pause"] forState:UIControlStateNormal];
//        [self watcher];
//    }
//}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
