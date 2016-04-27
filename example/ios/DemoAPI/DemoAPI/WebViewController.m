//
//  WebViewController.m
//  DemoAPI
//
//  Copyright © 2014-2016 iBecom. All rights reserved.
//

#import "WebViewController.h"
//#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController() <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *command;
@property (weak, nonatomic) IBOutlet UILabel *result;

@end

@implementation WebViewController

-(void)viewDidLoad {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:filePath]]];
    self.command.text = @"Math.sqrt(4)";
    self.result.text = @"";
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
//    JSContext * context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSLog(@"%@",context);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"init" ofType:@"json"];
    NSString *initJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initMap(%@)",initJSON]];
    NSLog(@"%@",result);
   
    filePath = [[NSBundle mainBundle] pathForResource:@"mapcanvas" ofType:@"json"];
    NSString *canvasJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    filePath = [[NSBundle mainBundle] pathForResource:@"poi" ofType:@"json"];
    NSString *poiJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
//    result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"loadMapCanvas(Canvas: \"%@\", POI: \"%@\")",canvasJSON,poiJSON]];
    result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"loadMapCanvas(%@, %@)",canvasJSON,poiJSON]];
    NSLog(@"%@",result);
    filePath = [[NSBundle mainBundle] pathForResource:@"routegraph" ofType:@"json"];
    NSString *routeJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"loadRoutes(%@)",routeJSON]];
    NSLog(@"%@",result);
//    result = [webView stringByEvaluatingJavaScriptFromString:@"document.defaultCmp(0,2)"];
//    NSLog(@"%@",result);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",request.URL  );
    if ([[request.URL fragment] containsString:@"response"]) {
        self.result.text = [[request.URL fragment] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        return NO;
    }
    return YES;
}

- (IBAction)execScript:(id)sender {
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:self.command.text];
    self.result.text = result;
}

@end
