//
//  FirstViewController.h
//  CustomPlayer
//
//  Created by Администратор on 4/11/13.
//  Copyright (c) 2013 gbksoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface FirstViewController : UIViewController
{
   // MPMoviePlayerController *player;
  //  UILabel * urProgressLabel;

 
}
@property (nonatomic,retain) IBOutlet  UIImageView * videoThumbnail;
@property (nonatomic,retain) IBOutlet  UIView * playbackView;
@property (nonatomic,retain) IBOutlet  UILabel * lProgress;
@property (nonatomic,retain) IBOutlet  UIButton * playerBtn;
@property (strong,retain) MPMoviePlayerController *player;
@property (retain, nonatomic) IBOutlet UISlider * slider;

-(IBAction)play:(id)sender;
-(IBAction)playVideo:(id)sender;
-(IBAction) onTimeSliderChange: (UISlider*)sender;
@end
