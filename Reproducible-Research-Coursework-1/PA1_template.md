---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---

## Loading and preprocessing the data

### 1. Load the data (i.e. read.csv())

```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.3.3
```

```r
activity <- read.csv("./activity/activity.csv")
```

### 2. Process/transform the data (if necessary) into a format suitable for your analysis

```r
activity$date <- as.POSIXct(activity$date, "Asia/Singapore","%Y-%m-%d")
```

## What is mean total number of steps taken per day?
#### For this part of the assignment, you can ignore the missing values in the dataset.
1. Calculate the total number of steps taken per day

```r
steps_perday <- aggregate(steps ~ date,data=activity, FUN=sum)
```

2. Make a histogram of the total number of steps taken each day

```r
hist(steps_perday$steps, main = "Histogram of Steps Per Day", xlab = "No. of steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

3. Calculate and report the mean and median of the total number of steps taken per day

```r
## Mean of the total number of steps taken per day
mean(steps_perday$steps)
```

```
## [1] 10766.19
```

```r
## Median of the total number of steps taken per day
median(steps_perday$steps)
```

```
## [1] 10765
```

## What is the average daily activity pattern?

```r
avg_steps_perday <- aggregate(steps~interval, activity, mean)
```

1. Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
plot(avg_steps_perday$interval, avg_steps_perday$steps, type = "l", main = "Average steps taken per 5 minutes interval", xlab = "Interval (minutes)", ylab = "No. of Steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
## Get the max value index and print interval value
cat("Interval ", avg_steps_perday$interval[which.max(avg_steps_perday$steps)], " with average of", max(avg_steps_perday$steps), " steps")
```

```
## Interval  835  with average of 206.1698  steps
```

## Imputing missing values
Note that there are a number of days/intervals where there are missing values (coded as NA). The presence of missing days may introduce bias into some calculations or summaries of the data.

1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
3. Create a new dataset that is equal to the original dataset but with the missing data filled in.
4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
## Are there differences in activity patterns between weekdays and weekends?
#### For this part the weekdays() function may be of some help here. Use the dataset with the filled-in missing values for this part.

1. Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.
2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.
