#import "ViewController.h"
#import "QuestionAnswerPair.h"

@implementation ViewController {
    UIButton *speakButton;
    UIButton *loadButton;
    UITextField *question;
    UITextField *answer;
    QuestionAnswerPair *qaPair;
}

-(void) loadView {
    CGRect viewRect = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:viewRect];
    [self  setView: view];
}

-(void) viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    speakButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    speakButton.frame = CGRectMake(100, 100, 100, 44);
    speakButton.tag = 100;
    
    loadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loadButton.frame = CGRectMake(100, 150, 100, 44);
    loadButton.tag = 500;
    
    qaPair = [[QuestionAnswerPair alloc] init ];
    [qaPair setQuestion:@"What's the best fish in the world"];
    [qaPair setAnswer:@"It's salmon"];
    
    [speakButton setTitle: @"Speak" forState:UIControlStateNormal];
    speakButton.enabled = NO;
    [speakButton addTarget:self action:@selector(speakSomething:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speakButton];
    //UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 200, 44)];
    //title.text = @"This is a text area";
    //[self.view addSubview:title];
    
    [loadButton setTitle: @"Load" forState:UIControlStateNormal];
    [loadButton addTarget:self action:@selector(loadQA:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadButton];
    
    question = [[UITextField alloc] initWithFrame:CGRectMake(50, 30, 200, 44)];
    question.tag = 200;
    [question setPlaceholder:@"Input Question here"];
    [question addTarget:self action:@selector(toggleSpeakButton:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:question];
    
    
    answer = [[UITextField alloc] initWithFrame:CGRectMake(50, 60, 200, 33)];
    answer.tag = 300;
    [answer setPlaceholder:@"Input Answer here"];
    [answer addTarget:self action:@selector(toggleSpeakButton:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:answer];
    
    

}

-(void) speakSomething:(UIButton *) sender {
    AVSpeechUtterance *speech = [AVSpeechUtterance speechUtteranceWithString:[self generateSpeechWithQuestion:question.text andAnswer:answer.text]];
    AVSpeechSynthesizer *speaker = [[AVSpeechSynthesizer alloc] init];
    speech.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-AU"];
    speech.rate = 0.3;
    [speaker speakUtterance:speech];
    for (AVSpeechSynthesisVoice *voice in [AVSpeechSynthesisVoice speechVoices]) {
        NSLog(@"%@",voice.language);
    }
    //NSLog(@"Finally I can speak but only in words");
}

-(void) loadQA:(UIButton *) sender {
    [question setText:qaPair.question];
    [answer setText:qaPair.answer];
    speakButton.enabled = YES;
}
-(void) toggleSpeakButton:(UITextField *) sender {
//    UITextField *question = (UITextField*)[self.view viewWithTag:200];
//    UITextField *answer = (UITextField*)[self.view viewWithTag:300];
//    UIButton *speakButton = (UIButton*)[self.view viewWithTag:100];
    
    if(question.text.length != 0 && answer.text.length != 0) {
        speakButton.enabled = YES;
        [(UIButton*)[self.view viewWithTag:100] setEnabled:YES];
    } else {
        [(UIButton*)[self.view viewWithTag:100] setEnabled:NO];
    }
    
}

-(NSString *) generateSpeechWithQuestion:(NSString *) lquestion andAnswer:(NSString *) lanswer {
    /****
     Where to put this method?
     ****/
    
    /**
     change the if condition to case or switch
     **/
    
    /*
    NSUInteger answerLength = [answer length];
    if(answerLength < 10) {
        
    }
     */
    NSString *result = [[lquestion stringByAppendingString:@"--10--9--8--7--6--5--4--3--2--1--"] stringByAppendingString:lanswer];
    return result;
}
//-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    self.view.backgroundColor = [UIColor yellowColor];
//}

@end