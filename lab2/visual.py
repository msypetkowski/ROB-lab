import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
from itertools import islice

def draw2DPlot(xData, yData, xLabel='x', yLabel='y'):
    assert len(xData) == len(yData)
    plt.plot(xData, yData)
    ax = plt.gca()
    ax.set_ylabel(yLabel)
    ax.set_xlabel(xLabel)


def load(filename):
    with open(filename, 'r') as f:
        ret = np.array([[float(j) for j in i.split(' ') if j]
                        for i in f.read().split('\n') if i])
    return ret[:, 1:]

def drawData(data):
    counts, breakpoints = np.histogram(data, bins=10)

    breakpoints = list(map(np.mean, zip(breakpoints, islice(breakpoints, 1, None))))
    counts = counts / len(data) / (breakpoints[1] - breakpoints[0])
    # draw2DPlot(breakpoints, counts)
    # draw2DPlot(range(len(hist)),)

    mu = np.mean(data)
    sigma = np.std(data)

    # mu = np.mean(data) 
    # sigma = 1
    x = np.linspace(mu - 3*sigma, mu + 3*sigma, 100)
    plt.plot(x,mlab.normpdf(x, mu, sigma))


    # plt.hist(data, bins='auto')  # arguments are passed to np.histogram
    # plt.title("histogram")
    # plt.show()
    return mu, sigma


def main():
    data1 = load('../iris/iris2.txt')
    data2 = load('../iris/iris3.txt')
    mu1, sigma1 = drawData(data1[:,2])
    mu2, sigma2 = drawData(data2[:,2])
    print('mu', mu1, mu2)
    m = np.mean([mu1, mu2])
    print('xopt', m)
    plt.plot([m, m], [0, 1])
    print('error1', (sum(d[2] > m for d in data1) / len(data1)))
    print('error2', (sum(d[2] <= m for d in data2) / len(data2)))
    print('error', (sum(d[2] > m for d in data1) +
                    sum(d[2] <= m for d in data2)) / len(data1 + data2))
    plt.show()

if __name__ == '__main__':
    main()
