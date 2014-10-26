//
//  CameraViewController.m
//  BizApp
//
//  Created by Charles Nebo on 26/10/14.
//  Copyright (c) 2014 charles Nebo. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _label.text = @"No image";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cameraButton:(id)sender {
    //_cameraLabel.text = @"Camera button pressed";
    [self startRealCameraControllerFromViewController:self usingDelegate:self];
}

- (IBAction)saveButton:(id)sender
{
    if (_imageView.image)
    {
        _label.text = @"Saving image ...";
        UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    else
    {
        _label.text = @"Cannot save: no image";
    }
}


- (IBAction)pictureButton:(id)sender
{
    //_label.text = @"Pressed the button.";
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (void) image:(UIImage *) image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo
{
    if (error)
    {
        _label.text = [NSString stringWithFormat:@"Error %ld: %@", (long)error.code, error.localizedDescription];
    } else {
        _label.text = @"Image saved.";
        _imageView.image = nil;
    }
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*)controller usingDelegate: (id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>)
delegate
{
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) || (delegate == nil) || (controller == nil))
    {
        return NO;
    }
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.delegate = delegate;
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

- (BOOL) startRealCameraControllerFromViewController: (UIViewController*)controller usingDelegate: (id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>)
delegate
{
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) || (delegate == nil) || (controller == nil))
    {
        return NO;
    }
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraUI.delegate = delegate;
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _label.text = [NSString stringWithFormat:@"Have image %d x %d", (int)image.size.width, (int)image.size.height];
    _imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
