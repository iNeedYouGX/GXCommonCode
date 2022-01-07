//
//  BCComConfigDefine.h
//  BCComConfigKit
//
//  Created by Basic on 2018/7/14.
//

#ifndef BCComConfigDefine_h
#define BCComConfigDefine_h


#pragma mark - resource

#define     kBCComConfig_BundleName              @"BCComConfigKit"
#define     kBCComConfig_BundleFullName          @"BCComConfigKit.bundle"

#define     BCComConfigImageNamed(name)          [UIImage imageNamed:name]?:(([UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",kBCComConfig_BundleFullName,name]])?:[UIImage imageNamed:[NSString stringWithFormat:@"Frameworks/%@.framework/%@/%@",kBCComConfig_BundleName,kBCComConfig_BundleFullName,name]])


#endif /* BCComConfigDefine_h */
