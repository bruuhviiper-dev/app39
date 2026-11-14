package com.mensagensdeamor.amor

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Widget "dias juntos": mostra o número de dias do relacionamento + nome do par.
 * Renderização NATIVA via RemoteViews. Dados gravados pelo Flutter (home_widget):
 * days_number / days_label / couple_name.
 */
class DaysWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val number = widgetData.getString("days_number", null) ?: "0"
            val label = widgetData.getString("days_label", null) ?: "dias juntos"
            val name = widgetData.getString("couple_name", null) ?: ""

            val views = RemoteViews(context.packageName, R.layout.days_widget).apply {
                setTextViewText(R.id.days_number, number)
                setTextViewText(R.id.days_label, label)
                setTextViewText(R.id.days_name, name)
                setOnClickPendingIntent(
                    R.id.days_root,
                    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                )
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
