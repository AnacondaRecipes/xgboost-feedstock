"""
A simple test for xgboost based on scikit-learn.

Note that xgboost's internal tests are NOT shipped with their
python package on PyPI. Hence our own test is rolled here.

For CUDA-enabled builds, this also exercises device='cuda' since
PBP CUDA workers have real GPUs.
"""
import xgboost
import sklearn.datasets
import sklearn.model_selection
import sklearn.metrics

X, y = sklearn.datasets.load_iris(return_X_y=True)
Xtrn, Xtst, ytrn, ytst = sklearn.model_selection.train_test_split(
    X, y, train_size=0.8, random_state=4)


def fit_and_score(device):
    clf = xgboost.XGBClassifier(
        max_depth=2,
        learning_rate=1,
        n_estimators=10,
        verbosity=0,
        objective='multi:softmax',
        device=device,
        seed=5)
    clf.fit(Xtrn, ytrn)
    ypred = clf.predict(Xtst)
    acc = sklearn.metrics.accuracy_score(ytst, ypred)
    print('xgboost ({}) accuracy on iris: {}'.format(device, acc))
    assert acc > 0.9, 'low accuracy on {}: {}'.format(device, acc)


fit_and_score('cpu')

build_info = xgboost.build_info()
print('build_info: USE_CUDA={}, USE_NCCL={}'.format(
    build_info.get('USE_CUDA'), build_info.get('USE_NCCL')))
if build_info.get('USE_CUDA'):
    fit_and_score('cuda')
