//
//  Singleton.h
//

#define SingletonInterface(name) +(instancetype)share##name

#if __has_feature(objc_arc)

// ARC
#define SingletonImplementation(name)                                                                                  \
    +(instancetype)share##name                                                                                         \
    {                                                                                                                  \
        return [[self alloc] init];                                                                                    \
    }                                                                                                                  \
    +(instancetype)allocWithZone : (struct _NSZone *)zone                                                              \
    {                                                                                                                  \
        static id instance;                                                                                            \
        static dispatch_once_t onceToken;                                                                              \
        dispatch_once(&onceToken, ^{                                                                                   \
            instance = [super allocWithZone:zone];                                                                     \
        });                                                                                                            \
        return instance;                                                                                               \
    }                                                                                                                  \
    -(id)copyWithZone : (NSZone *)zone                                                                                 \
    {                                                                                                                  \
        return self;                                                                                                   \
    }                                                                                                                  \
    -(id)mutableCopyWithZone : (NSZone *)zone                                                                          \
    {                                                                                                                  \
        return self;                                                                                                   \
    }
#else

// MRC
#define SingletonImplementation(name)                                                                                  \
    +(instancetype)share##name                                                                                         \
    {                                                                                                                  \
        return [[self alloc] init];                                                                                    \
    }                                                                                                                  \
    +(instancetype)allocWithZone : (struct _NSZone *)zone                                                              \
    {                                                                                                                  \
        static id instance;                                                                                            \
        static dispatch_once_t onceToken;                                                                              \
        dispatch_once(&onceToken, ^{                                                                                   \
            instance = [super allocWithZone:zone];                                                                     \
        });                                                                                                            \
        return instance;                                                                                               \
    }                                                                                                                  \
    -(id)copyWithZone : (NSZone *)zone                                                                                 \
    {                                                                                                                  \
        return self;                                                                                                   \
    }                                                                                                                  \
    -(id)mutableCopyWithZone : (NSZone *)zone                                                                          \
    {                                                                                                                  \
        return self;                                                                                                   \
    }                                                                                                                  \
    -(oneway void)release{} - (instancetype)retain                                                                     \
    {                                                                                                                  \
        return self;                                                                                                   \
    }                                                                                                                  \
    -(NSUInteger)retainCount                                                                                           \
    {                                                                                                                  \
        return MAXFLOAT;                                                                                               \
    }

#endif /* Singleton_h */
