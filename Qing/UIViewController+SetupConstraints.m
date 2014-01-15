#import "UIViewController+SetupConstraints.h"
#import <objc/runtime.h>

@implementation UIViewController (SetupConstraints)

- (void)setupConstraintsWithFormatStrings:(NSArray*)formatStringsArray {
  
  NSMutableDictionary *variableDictionary = [[NSMutableDictionary alloc] init];
  
  NSError *error;
  NSRegularExpression *classRegex = [NSRegularExpression regularExpressionWithPattern:@"T@\"(\\w+)\"" options:0 error:&error];
  
  unsigned int outCount, i;
  objc_property_t *properties = class_copyPropertyList([self class], &outCount);
  for (i = 0; i < outCount; i++) {
    objc_property_t property     = properties[i];
    NSString *propertyName       = [NSString stringWithCString:property_getName(property) encoding:NSASCIIStringEncoding];
    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSASCIIStringEncoding];
    
    // matches if this property is an Obj-C class, not an int, struct, etc.
    NSTextCheckingResult *match = [classRegex firstMatchInString:propertyAttributes options:0 range:NSMakeRange(0, [propertyAttributes length])];
    
    if (match) {
      NSRange classNameRange = [match rangeAtIndex:1]; // get the range of the capture group with just the class name
      NSString *className = [propertyAttributes substringWithRange:classNameRange];
      
      Class currentClass = NSClassFromString(className);
      if ([currentClass isSubclassOfClass:[UIView class]]) { 
        // overriding a warning, see http://stackoverflow.com/a/7933931/56273
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [[self performSelector:NSSelectorFromString(propertyName)] setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        // if the property is a UIView or a subclass of UIView, include it in the dictionary
        variableDictionary[propertyName] = [self performSelector:NSSelectorFromString(propertyName)];
        #pragma clang diagnostic pop
      }
    }
  }

  NSMutableArray *allConstraints = [NSMutableArray arrayWithCapacity:[formatStringsArray count]];
  for (NSString *formatString in formatStringsArray) {
    NSArray *constraintsFromFormatString = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:variableDictionary];
    [allConstraints addObjectsFromArray:constraintsFromFormatString];
  }
  
  [self.view addConstraints:allConstraints];
}

@end
